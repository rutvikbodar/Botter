import 'package:botter/CreateClan.dart';
import 'package:botter/cubits/app_theme_cubit.dart';
import 'package:botter/cubits/createclan_cubit.dart';
import 'package:botter/cubits/searchpeople_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class search extends StatefulWidget {
  const search({Key? key}) : super(key: key);
  @override
  State<search> createState() => _searchState();
}

class _searchState extends State<search> {
  @override
  Widget build(BuildContext context) {
    TextEditingController usernamecontroller = TextEditingController();
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Theme.of(context).backgroundColor,
        body: Column(
          children: <Widget>[
            Row(
              children: [
                Container(
                  margin: EdgeInsets.only(top: 25,left: 15),
                  height: 50,
                  width: 325,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                          color: (context).watch<AppThemeCubit>().state.textcolor,
                          width: 1
                      )
                  ),
                  padding: EdgeInsets.only(top: 10,bottom: 5,left: 15),
                  child: TextField(
                    controller: usernamecontroller,
                    style: TextStyle(
                      color: (context).watch<AppThemeCubit>().state.textcolor,
                    ),
                    autofocus: true,
                    textAlign: TextAlign.justify,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: "Search people",
                      hintStyle: TextStyle(
                        color: (context).watch<AppThemeCubit>().state.textcolor,
                      )
                    ),
                    onChanged: (val){
                      (context).read<SearchpeopleCubit>().searchuser(usernamecontroller.text);
                    },
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 25),
                  child: IconButton(onPressed:(){
                    (context).read<SearchpeopleCubit>().searchuser(usernamecontroller.text);
                  },
                      icon: Icon(Icons.search_outlined,color: (context).watch<AppThemeCubit>().state.textcolor,)),
                )
              ],
            ),
            BlocProvider(
              create: (context) => CreateclanCubit(),
              child: Builder(
                builder: (context) {
                  return CreateClan();
                }
              ),
            ),
            Expanded(
              child: Builder(
                builder: (context) {
                  SearchpeopleState stat = (context).watch<SearchpeopleCubit>().state;
                  if(stat is InitialsearchState){
                    return Row(
                      children: [
                        Container(
                          width: 80,
                        ),
                        Container(
                          width: 200,
                          child: Image.asset('assets/friends.png'),
                        ),
                        Container(
                          width: 10,
                        ),
                        Container(
                          child: Icon(Icons.question_mark_outlined,

                            color: (context).watch<AppThemeCubit>().state.textcolor,size: 33,),
                        )
                      ],
                    );
                  }
                  else if(stat is SearchresultState){
                    return ListView(
                      children: stat.generatesearchtiles((context).watch<AppThemeCubit>().state.textcolor),
                    );
                  }
                  else{
                    return Center(
                      child: Column(
                        children: [
                          Container(
                            height: 200,
                          ),
                          Icon(Icons.heart_broken_rounded,color: (context).watch<AppThemeCubit>().state.textcolor,size: 50,),
                          Text("No such user found!",
                            style: TextStyle(color: (context).watch<AppThemeCubit>().state.textcolor),
                          ),
                        ],
                      ),
                    );
                  }
                }
              ),
            )
          ],
        )
      ),
    );
  }
}
