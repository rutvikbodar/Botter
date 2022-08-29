import 'package:bloc/bloc.dart';
import 'package:botter/SearchListTile.dart';
import 'package:botter/database/database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
part 'searchpeople_state.dart';

class SearchpeopleCubit extends Cubit<SearchpeopleState> {
  databaseservice db;
  var snap;
  late List<Map<String,dynamic>> list;
  SearchpeopleCubit({required this.db}) : super(InitialsearchState()){
    initiate();
  }
  void initiate() async{
    snap = await db.usernames.doc("usernames").get();
    list = List<Map<String,dynamic>>.from(snap.get("usernames"));
  }
  void searchuser(String username){
    if(username.isEmpty){
      emit(InitialsearchState());
      return;
    }
    List<Map<String,dynamic>> results = List<Map<String,dynamic>>.empty(growable: true);
    for(Map<String,dynamic> d in list){
      String firebasedata = d["username"].toString().toLowerCase();
      if(firebasedata.contains(username.toLowerCase() as dynamic)){
        results.add(d);
      }
    }
    if(results.isEmpty){
      emit(NouserFound());
    }
    else{
      emit(SearchresultState(list: results));
    }
  }
}
