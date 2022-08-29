import 'dart:ui';
import 'package:bloc/bloc.dart';
import 'package:botter/database/database.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
part 'createclan_state.dart';
class CreateclanCubit extends Cubit<CreateclanState> {
  List<Map<String,dynamic>> datalist = List.empty(growable: true);
  CreateclanCubit() : super(CreateclanState(status: "Waiting for credentials...",statuscolor: Colors.orange,succeed: false));
  void clanAlreadyExists(){
    emit(CreateclanState(status: "Clan already Exists..!", statuscolor: Colors.red,succeed: false));
  }
  void passwordNotValid(){
    emit(CreateclanState(status: "Password must be hard to guess!", statuscolor: Colors.yellowAccent,succeed: false));
  }
  void clanNameEmpty(){
    emit(CreateclanState(status: "Clan name can not be empty", statuscolor: Colors.red, succeed: false));
  }
  void success(){
    emit(CreateclanState(status: "Clan created successfully!", statuscolor: Colors.green,succeed: true));
  }
  void spacesInClanName(){
    emit(CreateclanState(status: "Can not have spaces in clan name", statuscolor: Colors.red, succeed: false));
  }
  void spacesInPassword(){
    emit(CreateclanState(status: "Can not have spaces in password", statuscolor: Colors.red, succeed: false));
  }
  void CheckAvailibility(String clanname,String password,List<Map<String,dynamic>> lis,String uid,String username) async{
    clanname=clanname.trim();
    if(datalist.isEmpty){
      datalist = lis;
    }
    if(clanname.trim().isEmpty){
      clanNameEmpty();
      return;
    }
    List<String> splitlistofclanname = clanname.split(' ');
    if(splitlistofclanname.length>1){
      spacesInClanName();
      return;
    }
    List<String> splitlistofpassword = password.split(' ');
    if(splitlistofpassword.length>1){
      spacesInClanName();
      return;
    }
    List<Map<String,dynamic>> results = List<Map<String,dynamic>>.empty(growable: true);
    for(Map<String,dynamic> d in datalist){
      String firebasedata = d["username"].toString().toLowerCase();
      if(firebasedata==clanname.toLowerCase()){
        results.add(d);
      }
    }
    if(results.isNotEmpty){
      clanAlreadyExists();
      return;
    }
    else{
      databaseservice db = databaseservice(uid: uid);
      String securitycode = uid+username;
      String chatreference = clanname+securitycode;
      await db.clans.doc(clanname).set({
        "Admin" : {
          "username" : username,
          "uid" : uid
        },
        "clanname" : clanname,
        "securitycode" : uid,
        "password" : password,
        "members" : [],
        "blockedmembers" : [],
        "chatreference" : chatreference
      }).then((value){
        datalist.add({"username" : clanname});
        success();
      }
      );
      await db.usernames.doc("usernames").update({
        "usernames" : FieldValue.arrayUnion([{
          "username" : clanname,
          "uid" : chatreference,
          "isperson" : false
        }])
      });
      await db.clanchats.doc(chatreference).set({
        "chat" : []
      });
    }
  }
}
