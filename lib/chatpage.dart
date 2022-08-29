import 'package:botter/cubits/app_theme_cubit.dart';
import 'package:botter/cubits/individualchat_cubit.dart';
import 'package:botter/cubits/sendbutton_cubit.dart';
import 'package:botter/cubits/username_cubit.dart';
import 'package:botter/user.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'cubits/friendsprofilepicture_cubit.dart';
import 'cubits/newmessages_cubit.dart';
import 'package:badges/badges.dart';

class chatpage extends StatefulWidget{
  Map<String,dynamic> data;
  String documentreference;
  chatpage({required this.data,required this.documentreference});

  @override
  State<chatpage> createState() => _chatpageState();
}

class _chatpageState extends State<chatpage> {
  bool isanonomous = false;
  Alignment _alignment = Alignment.centerLeft;
  Widget _icon = Container(
    height: 60,
    width: 40,
    decoration: BoxDecoration(borderRadius: BorderRadius.circular(20),color: Colors.deepOrange,),
    child: Image.asset('assets/open.png'),
  );
  void togglemode(){
    if(!isanonomous){
      setState((){
        _alignment = Alignment.centerRight;
        isanonomous = true;
        _icon = Container(
          height: 60,
          width: 40,
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(20),color: Colors.deepOrange,),
          child: Image.asset('assets/ghost.png'),
        );
      });
    }
    else{
      setState((){
        _alignment = Alignment.centerLeft;
        isanonomous = false;
        _icon = Container(
          height: 60,
          width: 40,
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(20),color: Colors.deepOrange,),
          child: Image.asset('assets/open.png',),
        );
      });
    }
  }
  ScrollController scrollController = ScrollController();
  @override
  void dispose(){
    scrollController.dispose();
    individualchatdispose();
    super.dispose();
  }

  Widget chatstatusprovider(int n,bool seen){
    if(n!=0){
      return Container(
        margin: EdgeInsets.only(right: 14),
        child: Badge(
          badgeColor: Colors.white10,
          badgeContent: Text(n.toString(),style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
          child: Icon(Icons.timer_outlined,color: Colors.white,),
          animationType: BadgeAnimationType.fade,
          animationDuration: Duration(milliseconds: 200),
          toAnimate: true,
        ),
      );
    }
    else if(seen){
      return Container(
        margin: EdgeInsets.only(right: 14),
        child: Icon(Icons.remove_red_eye_outlined,color: Colors.white,),
      );
    }
    else{
      return Container(height: 0,);
    }
  }

  late Function individualchatdispose;
  @override
  Widget build(BuildContext context) {
    TextEditingController controller = TextEditingController();
    String URL = (context).read<FriendsprofilepictureCubit>().state.url;
    return MultiBlocProvider(
  providers: [
    BlocProvider(
      create: (context) => IndividualchatCubit(isperson: widget.data["isperson"],uid: Provider.of<user>(context,listen: false).uid.toString(),documentreference: widget.documentreference,currentuser: (context).read<UsernameCubit>().state.username),
),
    BlocProvider(
      create: (context) => SendbuttonCubit(),
    ),
    ],
      child: MaterialApp(
        home: Builder(
          builder: (context) {
          individualchatdispose = (context).read<IndividualchatCubit>().disposechat;
          return Scaffold(
            backgroundColor: (context).read<AppThemeCubit>().state.background,
            body: Column(
              children: [
                Container(
                  height: 23,
                ),

                Container(
                  height: 80,
                  decoration: BoxDecoration(
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black54,
                        blurRadius: 2,
                        spreadRadius: 2
                      )
                    ],
                    color: (context).read<AppThemeCubit>().state.background,
                  ),
                  child: Row(
                    children: [
                      CachedNetworkImage(
                        imageUrl: URL,
                        imageBuilder: (context, imageProvider) => Container(
                          height: 60,
                          width: 60,
                          margin: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            color: Colors.white,
                            boxShadow: [BoxShadow(color: Colors.green,blurRadius: 5)],
                            image: DecorationImage(
                              image: imageProvider,
                              fit: BoxFit.cover,),
                          ),
                        ),
                        placeholder: (context, url) => CircularProgressIndicator(),
                        errorWidget: (context, url, error) => Container(
                          height: 60,
                          width: 60,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30),
                              color: Colors.white,
                              boxShadow: [BoxShadow(color: Colors.green,blurRadius: 5)],
                              image: DecorationImage(
                                  image: AssetImage('assets/defaultprofile.png')
                              )
                          ),
                        ),
                      ),

                      Container(
                        width: 230,
                        child: Text(widget.data["username"],
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: (context).read<AppThemeCubit>().state.textcolor,
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Container(
                        width: 70,
                        padding: EdgeInsets.only(left: 35),
                        child: IconButton(
                            onPressed: null,
                            icon : Icon(
                              widget.data["isperson"]?Icons.person_pin_outlined:Icons.settings_suggest_rounded,
                              color: (context).read<AppThemeCubit>().state.textcolor,
                            )
                        ),
                      )
                    ],
                  ),
                ),
                Container(
                  color: Colors.transparent,
                  height: (widget.data["isperson"]==true)?0:40,
                  child:
                  Row(
                    children: <Widget>[
                      SizedBox(width: 5,),
                      Expanded(
                          child: Container(
                            margin: EdgeInsets.only(top: 5,bottom: 5),
                            decoration: BoxDecoration(
                              color: Colors.green,
                              borderRadius: BorderRadius.circular(20)
                            ),
                          )
                        ),
                      Container(
                        width: 80,
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            Container(
                              height: 10,
                              width: 60,
                              decoration: BoxDecoration(color: Colors.white54,borderRadius: BorderRadius.circular(10)),
                            ),
                            AnimatedContainer(
                              curve: Curves.easeIn,
                              duration: Duration(milliseconds: 200),
                              alignment: _alignment,
                              child: IconButton(
                                onPressed: togglemode,
                                icon: _icon,
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                    child: Container(
                      child: Builder(
                        builder: (context) {
                        IndividualchatState stat = (context).watch<IndividualchatCubit>().state;
                          return ListView(
                          controller: scrollController,
                          reverse: true,
                          children: stat.messagetiles,
                          padding: EdgeInsets.all(10),
                      );
                    }
                  )
                )
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: Builder(
                      builder: (context) {
                        return chatstatusprovider((context).watch<IndividualchatCubit>().newmessagestack.length, (context).watch<IndividualchatCubit>().seen);
                      },
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(bottom: 5),
                  width: double.infinity,
                  //color: Colors.greenAccent,
                  child: Stack(
                    alignment: Alignment.bottomCenter,
                    children: [
                      Container(
                        margin: EdgeInsets.only(right: 342,bottom: 5),
                        height: 40,
                        width: 40,
                        //color: Colors.green,
                        child: Icon(Icons.emoji_emotions_outlined,color: (context).read<AppThemeCubit>().state.textcolor,),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                            width: 2,
                            color: (context).read<AppThemeCubit>().state.textcolor
                          ),
                          borderRadius: BorderRadius.circular(15),
                          //color: Colors.pink,
                        ),
                        width: 292,
                        constraints: BoxConstraints(minHeight: 40,maxHeight: 300),
                        padding: EdgeInsets.only(left: 15,right: 15,top: 5),
                        child: TextField(
                          controller: controller,
                          maxLines: null,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: "How about Hey...?",
                            hintStyle: TextStyle(color: (context).read<AppThemeCubit>().state.textcolor,fontSize: 15,),
                            alignLabelWithHint: true,
                          ),
                          style: TextStyle(color: (context).read<AppThemeCubit>().state.textcolor,fontSize: 15,),
                          onChanged: (val){
                            (context).read<SendbuttonCubit>().changeintext(val);
                          },
                        ),
                      ),
                      Container(
                        child: Container(
                          margin: EdgeInsets.only(left: 342,bottom: 5),
                          height: 40,
                          width: 40,
                          //color: Colors.green,
                          child: BlocBuilder<SendbuttonCubit,SendbuttonState>(
                            builder: (context, state) {
                              return IconButton(
                                icon: state.icon,
                                  onPressed: (state.isheart)?
                                  () async{
                                    (context).read<IndividualchatCubit>().addtostack((context).read<UsernameCubit>().state.username, isanonomous, "##heart-#");
                                    if(widget.data["isperson"]){
                                      await (context).read<NewmessagesCubit>().seen();
                                    }
                                  }
                                  :
                                  () async{
                                    String temp = controller.text;
                                    controller.clear();
                                    (context).read<SendbuttonCubit>().changeintext("");
                                    (context).read<IndividualchatCubit>().addtostack((context).read<UsernameCubit>().state.username, isanonomous, temp);
                                    if(widget.data["isperson"]){
                                      await (context).read<NewmessagesCubit>().seen();
                                    }
                                  }
                              );
                            },
                          )

                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          );
        }
      ),
    ),
    );
  }
}
