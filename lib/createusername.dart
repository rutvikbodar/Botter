import 'package:botter/cubits/setusername_cubit.dart';
import 'package:botter/cubits/username_cubit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class createusername extends StatefulWidget {
  const createusername({Key? key}) : super(key: key);

  @override
  State<createusername> createState() => _createusernameState();
}

class _createusernameState extends State<createusername> {
  String notice = "Yet To Set!";
  String tempuser = "";
  String checkstatus(String username,bool changedstatus){
    if(changedstatus){
      return username;
    }
    else{
      return "Please set username to use this feature";
    }
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
          backgroundColor: Color(0xff1b3234),
          body: Column(
            children: <Widget>[
              Container(
                  child: Image.asset("assets/botter.png")),
              Center(
                child: Container(
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(15),color: Colors.white),
                  width: 220,
                  alignment: Alignment.center,
                  child: TextFormField(
                    cursorColor: Color(0xff1b3234),
                    cursorWidth: 7,
                    autofocus: true,
                    style: TextStyle(fontWeight: FontWeight.bold,fontSize: 30,letterSpacing: 1,decoration: TextDecoration.none,),
                    decoration: InputDecoration(contentPadding : EdgeInsets.only(left: 20),hintText: "Enter Desired Username!",hintStyle: TextStyle(color: Color(0xff1b3234),fontWeight: FontWeight.bold,fontSize: 14),border: InputBorder.none,focusedBorder: InputBorder.none,enabledBorder: InputBorder.none,disabledBorder: InputBorder.none),
                    onChanged: (val){
                      tempuser=val;
                      },
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 10),
                child: BlocConsumer<SetusernameCubit, SetusernameState>(
                  listener: (context, state) {
                    if(state is setresult){
                      notice = state.status;
                    }
                  },
                  builder: (context, state) {
                    return Text(notice,style: TextStyle(fontSize: 10,color: Colors.yellow),);
                    },
                ),
              )
            ],
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              BlocProvider.of<SetusernameCubit>(context).tryaddinguser(tempuser, (context).read<UsernameCubit>().state.iscreated);
              },
            child: Icon(Icons.rocket_launch_outlined),
          ),
        ),
      );
  }
}
