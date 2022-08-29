import 'package:botter/cubits/app_theme_cubit.dart';
import 'package:botter/cubits/createclan_cubit.dart';
import 'package:botter/cubits/searchpeople_cubit.dart';
import 'package:botter/cubits/username_cubit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CreateClan extends StatefulWidget {
  const CreateClan({Key? key}) : super(key: key);

  @override
  State<CreateClan> createState() => _CreateClanState();
}

class _CreateClanState extends State<CreateClan> {
  double height = 60;
  double width = 200;
  bool isexpanded = false;
  TextEditingController clanname = TextEditingController();
  TextEditingController password = TextEditingController();
  Widget providechild(){
    if(!isexpanded){
      return Row(
        children: [
          Container(
            child: Icon(Icons.group_add_outlined,color: (context).read<AppThemeCubit>().state.textcolor,),
            margin: EdgeInsets.only(left: 15,right: 15),
          ),
          Text(
            "Create new Clan",
            style: TextStyle(
                color: (context).read<AppThemeCubit>().state.textcolor,
                fontSize: 15,
                fontWeight: FontWeight.bold
            ),
          )
        ],
      );
    }
    else{
      return Column(
        children: [
          SizedBox(
            height: 10,
          ),
          Row(
            children: [
              Container(
                margin: EdgeInsets.only(left: 10),
                child: Text("Clan name : ",
                  style: TextStyle(
                      color: (context).read<AppThemeCubit>().state.textcolor,
                      fontSize: 20,
                      fontWeight: FontWeight.bold
                  ),),
              ),
              SizedBox(
                width: 10,
              ),
              Expanded(
                child: TextField(
                  controller: clanname,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: (context).read<AppThemeCubit>().state.textcolor,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(
                width: 20,
              )
            ],
          ),
          Row(
            children: [
              Container(
                margin: EdgeInsets.only(left: 10),
                child: Text("Password : ",
                  style: TextStyle(
                      color: (context).read<AppThemeCubit>().state.textcolor,
                      fontSize: 20,
                      fontWeight: FontWeight.bold
                  ),),
              ),
              SizedBox(
                width: 15,
              ),
              Expanded(
                child: TextField(
                  controller: password,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: (context).read<AppThemeCubit>().state.textcolor,
                      fontSize: 20,
                      fontWeight: FontWeight.bold
                  ),
                ),
              ),
              SizedBox(
                width: 20,
              )
            ],
          ),
          SizedBox(
            height: 20,
          ),
          Row(
            children: [
              SizedBox(
                width: 20,
              ),
              Container(
                width: 260,
                child: Text(
                  (context).watch<CreateclanCubit>().state.status,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: (context).watch<CreateclanCubit>().state.statuscolor,
                    fontSize: 15
                  ),
                ),
              ),
              IconButton(
                icon: Icon(Icons.build_outlined,
                  color: (context).read<AppThemeCubit>().state.textcolor,),
                onPressed:  ()=>(context).read<CreateclanCubit>().CheckAvailibility(clanname.text, password.text, (context).read<SearchpeopleCubit>().list, (context).read<UsernameCubit>().db.uid!, (context).read<UsernameCubit>().state.username),
              )
            ],
          )
        ],
      );
    }
  }
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: GestureDetector(
        onTap: () async{
          if(height==60 && width==200){
            setState(() {
              height = 180;
              width = 350;
            },);
            await Future.delayed(Duration(milliseconds: 200));
            setState(() => isexpanded = true,);
          }
          else{
            setState(() {
              height = 60;
              width = 200;
              isexpanded = false;
            },);
          }
        },
        child: AnimatedContainer(
          margin: EdgeInsets.only(top: 5,left: 20),
          duration: Duration(milliseconds: 200),
          height: height,
          width: width,
          decoration: BoxDecoration(
            color: Colors.white12,
            borderRadius: BorderRadius.circular(30),
            border: Border.all(
              color: (context).read<AppThemeCubit>().state.textcolor,
              width: 2
            )
          ),
          child: providechild(),
        ),
      ),
    );
  }
}
