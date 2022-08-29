import 'dart:async';
import 'package:botter/cubits/app_theme_cubit.dart';
import 'package:botter/database/database.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import '../chattile.dart';
part 'getfriendandbloclist_state.dart';

class GetfriendandbloclistCubit extends Cubit<GetfriendandbloclistState> with HydratedMixin{
  late StreamSubscription firebasestream;
  databaseservice db;
  GetfriendandbloclistCubit({required this.db}) : super(GetfriendandbloclistState(uid: db.uid.toString(),friends: [],blocks: [], searchcode: '')){
    initialize();
  }
  void initialize() async{
    firebasestream = await db.friends.doc(db.uid).snapshots().listen((event) {
      List<Map<String,dynamic>>friends = List<Map<String,dynamic>>.from(event.get("friendslist"));
      List<Map<String,dynamic>>blocks = List<Map<String,dynamic>>.from(event.get("blocklist"));
      emit(GetfriendandbloclistState(uid: db.uid.toString(),friends: friends,blocks: blocks,searchcode: ""));
    });
  }
  void searchspecificchat(String searchcode){
    emit(GetfriendandbloclistState(uid: db.uid.toString(),friends: state.friends,blocks: state.blocks, searchcode: searchcode));
  }

  @override
  GetfriendandbloclistState? fromJson(Map<String, dynamic> json) {
    GetfriendandbloclistState.fromMap(json);
  }

  @override
  Map<String, dynamic>? toJson(GetfriendandbloclistState state) {
    state.toMap();
  }
}
