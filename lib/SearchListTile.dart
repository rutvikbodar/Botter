import 'package:botter/cubits/addblockfriends_cubit.dart';
import 'package:botter/cubits/app_theme_cubit.dart';
import 'package:botter/cubits/getfriendandbloclist_cubit.dart';
import 'package:botter/cubits/joinclan_cubit.dart';
import 'package:botter/cubits/username_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

class SearchListTile extends StatefulWidget {
  final Map<String,dynamic> usernamemap;
  const SearchListTile({required this.usernamemap});
  @override
  State<SearchListTile> createState() => _SearchListTileState();
}

class _SearchListTileState extends State<SearchListTile> {
  TextEditingController passwordcontroller= TextEditingController();
  @override
  Widget build(BuildContext context) {
    return ListTile(
      textColor: (context).watch<AppThemeCubit>().state.textcolor,
      title: Text(widget.usernamemap["username"].toString()),
      trailing: Builder(
        builder: (context) {
          GetfriendandbloclistState stat = (context).watch<GetfriendandbloclistCubit>().state;
          AppThemeState themestate = (context).watch<AppThemeCubit>().state;
          return IconButton(
            icon: stat.friendblockiconprovider(widget.usernamemap["username"].toString(),themestate.textcolor),
            onPressed: (){
              if(widget.usernamemap["isperson"]==true){
                String ownusername = (context).read<UsernameCubit>().state.username.toString();
                String ownuid = (context).read<UsernameCubit>().db.uid.toString();
                (context).read<AddblockfriendsCubit>().addfriend(ownuid, widget.usernamemap["uid"], ownusername, widget.usernamemap["username"],widget.usernamemap["isperson"]);
              }
              else{
                showDialog(
                    context: context,
                    builder: (_){
                      return BlocProvider.value(
                        value: JoinclanCubit(uid: (context).read<UsernameCubit>().db.uid.toString(),username: (context).read<UsernameCubit>().state.username,clanname: widget.usernamemap["username"].toString(),clanaddress: widget.usernamemap["uid"].toString()),
                          child: Builder(
                            builder: (context) {
                              return Dialog(
                              backgroundColor: Colors.white10,
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                              insetPadding: EdgeInsets.only(left: 50,right: 50),
                              child: Container(
                              height: 120,
                              padding: EdgeInsets.all(5),
                              child: Column(
                                children: [
                                  Row(
                                    children: <Widget>[
                                      Text("Password : ",style: TextStyle(fontSize: 25,color: Colors.white,fontWeight: FontWeight.bold),),
                                      SizedBox(width: 7,),
                                      Expanded(child: TextField(controller: passwordcontroller,style: TextStyle(fontSize: 25,color: Colors.white,fontWeight: FontWeight.bold,),textAlign: TextAlign.center,))
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Container(
                                        width: 230,
                                        child: Text((context).watch<JoinclanCubit>().state.status,style: TextStyle(fontWeight: FontWeight.bold,color: (context).watch<JoinclanCubit>().state.textcolor),),
                                      ),
                                      Container(
                                        alignment: Alignment.bottomRight,
                                        child: IconButton(icon: Icon(Icons.arrow_circle_right_outlined,color: Colors.green,),
                                          onPressed: () => (context).read<JoinclanCubit>().checkjoiningcredentials(passwordcontroller.text),
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                        ),
                      );
                            }
                          ),
                      );
                    }
                );
              }
            },
          );
        }
      ),
    );
  }
}
