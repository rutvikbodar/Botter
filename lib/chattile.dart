import 'dart:math';
import 'package:botter/chatpage.dart';
import 'package:botter/cubits/friendsprofilepicture_cubit.dart';
import 'package:botter/cubits/newmessages_cubit.dart';
import 'package:botter/database/database.dart';
import 'package:botter/database/generator.dart';
import 'package:botter/user.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'cubits/username_cubit.dart';

class chattile extends StatefulWidget {
  Key? key;
  Function fun;
  Color color;
  String ownuid;
  Map<String,dynamic> frienddata;
  chattile({required this.ownuid,required this.frienddata,required this.color,required this.fun,this.key});
  @override
  State<chattile> createState() => _chattileState();
}

class _chattileState extends State<chattile> {
  Widget defaultprofilecontainer = Container(
    height: 50,
    width: 50,
    decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(45),
        color: Colors.white,
        boxShadow: [BoxShadow(color: Colors.yellowAccent,blurRadius: 5)],
        image: DecorationImage(
            image: AssetImage('assets/defaultprofile.png')
        )
    ),
  );
  @override
  void dispose(){
    //disposefunction();
    super.dispose();
  }
  late Function disposefunction;
  @override
  Widget build(BuildContext context) {
    databaseservice db = databaseservice(uid: Provider.of<user>(context).uid);
    generator g = generator();
    String docreferance;
    if(widget.frienddata["isperson"]){
      docreferance= g.generateid(widget.ownuid, widget.frienddata["uid"]);
    }
    else{
      docreferance = widget.frienddata["uid"];
    }
    Stream<DocumentSnapshot<Object?>>? scorestream(){
      try{
        return db.chat.doc(docreferance).snapshots();
      }
      catch(e){
        print("snapshot not yet created exception");
      }
    }
    NewmessagesCubit nmc = NewmessagesCubit(uid: Provider.of<user>(context,listen: false).uid.toString(), documenreference: docreferance,currentusername: (context).read<UsernameCubit>().state.username);
    FriendsprofilepictureCubit ffp = FriendsprofilepictureCubit(uid: widget.frienddata["uid"]);
    return MultiBlocProvider(
  providers: [
    BlocProvider(
        create: (context) => nmc,
),
    BlocProvider(
      create: (context) => ffp,
    ),
  ],
    child: Builder(
          builder: (context) {
            disposefunction = (){
              (context).read<NewmessagesCubit>().disposemessage();
            };
            String URL = (context).watch<FriendsprofilepictureCubit>().state.url;
            return ListTile(
              leading: (URL!="")?
              CachedNetworkImage(
                imageUrl: URL,
                imageBuilder: (context, imageProvider) => Container(
                  height: 50,
                  width: 50,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(45),
                    color: Colors.white,
                    boxShadow: [BoxShadow(color: Colors.yellowAccent,blurRadius: 5)],
                    image: DecorationImage(
                        image: imageProvider,
                        fit: BoxFit.cover,),
                  ),
                ),
                placeholder: (context, url) => defaultprofilecontainer,
                errorWidget: (context, url, error) => defaultprofilecontainer
              ):
              Container(
                height: 50,
                width: 50,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(45),
                    color: Colors.white,
                    boxShadow: [BoxShadow(color: Colors.yellowAccent,blurRadius: 5)],
                    image: DecorationImage(
                        image: AssetImage('assets/defaultprofile.png')
                    )
                ),
              ),
              title: Container(
                child: Text(widget.frienddata["username"],style: TextStyle(color: widget.color,fontSize: 22.5),)
              ),
              subtitle: (widget.frienddata["isperson"]) ?
              StreamBuilder<DocumentSnapshot>(
              stream: scorestream(),
              builder: (context, snapshot) {
                if(snapshot.hasData) return Text("Score : "+min<int>(snapshot.data?.get("user1score"), snapshot.data?.get("user2score")).toString(),style: TextStyle(fontSize: 12,color: Colors.orange),);
                else{
                return Text("loading...",style: TextStyle(fontSize: 12,color: Colors.orange),);
                }
              }
              ):
                  StreamBuilder<DocumentSnapshot>(
                    stream: db.clans.doc(widget.frienddata["username"]).snapshots(),
                      builder: (context,snapshot){
                      if(snapshot.hasData){
                        return Text("leader : "+snapshot.data?.get("Admin")["username"],style: TextStyle(fontSize: 12,color: Colors.green.shade400),);
                      }
                      else{
                        return Text("loading...",style: TextStyle(fontSize: 12,color: Colors.green.shade400),);
                      }
                  }
                  ),
              trailing: Builder(builder: (context) {
                NewmessagesState stat = (context).watch<NewmessagesCubit>().state;
                return stat.icon;
              }),
            onTap: (){
                if(widget.frienddata["isperson"]==true){
                  (context).read<NewmessagesCubit>().seen();
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return BlocProvider.value(
                      value: nmc,
                      child: BlocProvider.value(
                        value: ffp,
                        child: Builder(
                          builder: (context) {
                            return chatpage(data: widget.frienddata,documentreference: docreferance);
                          }
                        ),
                        ),
                    );})
                  );
                }
                else{
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return BlocProvider.value(
                      value: ffp,
                      child: chatpage(data: widget.frienddata,documentreference: docreferance),
                        );
                      }
                    )
                  );
                }
            },
          );
        }
      ),
    );
  }
}
