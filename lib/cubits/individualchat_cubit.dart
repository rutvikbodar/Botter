import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:botter/groupmessagetile.dart';
import 'package:botter/messagetile.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import '../database/database.dart';
part 'individualchat_state.dart';

class IndividualchatCubit extends Cubit<IndividualchatState>{
  bool seen = false;
  bool isdaemonrunning = false;
  bool isperson;
  bool isdisposed = false;
  String uid;
  String currentuser;
  late databaseservice db;
  String documentreference;
  late StreamSubscription snapshots;
  List<Map<String,dynamic>> newmessagestack = List.empty(growable: true);
  IndividualchatCubit({required this.isperson,required this.uid,required this.documentreference,required this.currentuser}) : super(IndividualchatState(currentuser: currentuser,isperson: isperson, chat: [])){
    db = databaseservice(uid : uid.toString());
    if(isperson){
      snapshots = db.chat.doc(documentreference).snapshots().listen((event) async {
        print(seen);
        if(!isdisposed){
          if(currentuser==event.get("user1")){
            if(event.get("oldchatlengthuser2")==event.get("chat").length){
              seen = true;
            }
            else{
              seen = false;
            }
            await db.chat.doc(documentreference).update({
              "oldchatlengthuser1" : event.get("chat").length
            });
          }
          else{
            if(event.get("oldchatlengthuser1")==event.get("chat").length){
              seen = true;
            }
            else{
              seen = false;
            }
            print(seen);
            await db.chat.doc(documentreference).update({
              "oldchatlengthuser2" : event.get("chat").length
            });
          }
        }
          if(event.exists){
          List<Map<String,dynamic>> chat = List<Map<String,dynamic>>.from(event.get("chat"));
          emit(IndividualchatState(chat: chat,currentuser: currentuser,isperson: isperson,snap: event));
          }
      });
    }
    else{
      snapshots = db.clanchats.doc(documentreference).snapshots().listen((event) async {
          List<Map<String,dynamic>> chat = List<Map<String,dynamic>>.from(event.get("chat"));
          emit(IndividualchatState(chat: chat,currentuser: currentuser,isperson: isperson,snap:event));
      });
    }
  }

  void addtostack(String from,bool isano,String text){
    newmessagestack.add({
      'from' : from,
      'isano' : isano,
      'text' : text
    });
    List<Map<String,dynamic>> chat = state.chat;
    if(newmessagestack.isNotEmpty){
      newmessagestack.forEach((element) {
        chat.add({
          'from' : element['from'],
          'isano' : element['isnao'],
          'text' : element['text'],
          'timestamp' : Timestamp.now()
        });
      });
    }
    print(newmessagestack.length);
    if(!isdaemonrunning){
      isdaemonrunning = true;
      Daemon().then((value) => isdaemonrunning=false);
    }
  }

  Future<void> Daemon() async{
    while(newmessagestack.isNotEmpty){
        print("new message daemon running");
        await addmessage(newmessagestack[0]['from'], newmessagestack[0]['isano'], newmessagestack[0]['text']);
        newmessagestack.removeAt(0);
        print("stack size is : "+newmessagestack.length.toString());
        if(newmessagestack.length==0){
          print("Stack drained successfully");
        }
    }
  }

  Future<void> addmessage(String from,bool isano,String text) async{
    if(text.isEmpty) return;
    if(text.trim().isEmpty) return;
    text=text.trimLeft();
    text=text.trimRight();
    List<String> l = text.split("");
    String textfrom = from;
    if(isano==true){
      textfrom="Ghost";
    }
    var chatlis = state.snap?.get("chat");
    chatlis.add({
      "from" : textfrom,
      "isano" : isano,
      "text" : text,
      "timestamp" : DateTime.now()
    });
    if(isperson){
      await db.chat.doc(documentreference).update({
        "chat" : chatlis
      });
      if(state.snap?.get("user1")==currentuser){
        await db.chat.doc(documentreference).update({
          "user1score" : state.snap?.get("user1score")+1,
        });
      }
      else{
        await db.chat.doc(documentreference).update({
          "user2score" : state.snap?.get("user2score")+1,
        });
      }
    }
    else{
      await db.clanchats.doc(documentreference).update({
        "chat" : chatlis
      });
    }
  }
  void disposechat() async{
    isdisposed = true;
    await stream.drain();
  }

  @override
  Future<void> close()async {
    snapshots.cancel();
    return super.close();
  }
}