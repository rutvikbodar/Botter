import 'dart:ui';
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../database/database.dart';
part 'joinclan_state.dart';

class JoinclanCubit extends Cubit<JoinclanState> {
  late String username;
  late String uid;
  String clanname;
  String clanaddress;
  late databaseservice db;
  JoinclanCubit({required this.username,required this.uid,required this.clanname,required this.clanaddress}) : super(JoinclanInitial()){
    db = databaseservice(uid: this.uid);
  }

  void checkjoiningcredentials(String pwd) async {
    var onlinepwdsnap = await db.clans.doc(clanname).get();
    String onlinepassword = onlinepwdsnap.get("password").toString();
    List<String> blocklist = List<String>.from(onlinepwdsnap.get("blockedmembers"));
    if(blocklist.contains(username)){
      emit(JoinclanResultState(status: "You are Prohibited in this clan.", textcolor: Colors.red));
    }
    else if(onlinepassword==pwd){
      emit(JoinclanResultState(status: "Processing",textcolor: Colors.yellow.shade400));
      await db.clans.doc(clanname).update({
        "members" : FieldValue.arrayUnion([username])
      });
      await db.friends.doc(uid).update({
        "friendslist" : FieldValue.arrayUnion([{
          "uid" : clanaddress,
          "username" : clanname,
          "isperson" : false
        }])
      });
      emit(JoinclanResultState(status: "Joined clan successfully",textcolor: Colors.green));
    }
    else{
      emit(JoinclanResultState(status: "Incorrect Password", textcolor: Colors.yellow));
    }
  }
}
