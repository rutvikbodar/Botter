import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import '../database/database.dart';
part 'newmessages_state.dart';
class NewmessagesCubit extends Cubit<NewmessagesState> {
  String uid;
  String currentusername;
  int initial = 0;
  String documenreference;
  late databaseservice db;
  late StreamSubscription messagestream;
  NewmessagesCubit({required this.uid,required this.documenreference,required this.currentusername}) : super(NewmessagesState(newmessages: 0)){
    db = databaseservice(uid: uid);
    var temp = db.chat.doc(documenreference).snapshots();
    messagestream = temp.listen((event) {
      int diff = 0;
      if(event.exists){
        if(currentusername==event.get("user1").toString()){
          diff = event.get("chat").length - event.get("oldchatlengthuser1");
        }
        else{
          diff = event.get("chat").length - event.get("oldchatlengthuser2");
        }
        try{
          emit(NewmessagesState(newmessages: diff));
        }
        catch(Exception){
          print("Exception in the new message cubit");
        }
      }
      else{
        emit(NewmessagesState(newmessages: 0));
      }
    });
  }
  void emitmessagestate(int diff) async{
    if(diff>0){
      while(initial!=diff){
        initial++;
        try{
          emit(NewmessagesState(newmessages: initial));
        }
        catch(Exception){
          print("Exception from new message cubit");
        }
        await Future.delayed(Duration(milliseconds: 50));
      }
    }
  }
  void reset(){
    emit(NewmessagesState(newmessages: 0));
    seen();
  }
  Future<void> seen() async{
    var temp = await db.chat.doc(documenreference).get();
    int length = temp.get("chat").length;
    String u1 = temp.get("user1");
    if(u1==currentusername){
      await db.chat.doc(documenreference).update({
        "oldchatlengthuser1" : length
      });
    }
    else{
      await db.chat.doc(documenreference).update({
        "oldchatlengthuser2" : length
      });
    }
  }
  void disposemessage() async{
    await stream.drain();
  }
  @override
  Future<void> close()async {
    messagestream.cancel();
    super.close();
  }
}
