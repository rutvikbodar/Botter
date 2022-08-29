import 'package:bloc/bloc.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
part 'friendsprofilepicture_state.dart';

class FriendsprofilepictureCubit extends Cubit<FriendsprofilepictureState> {
  String uid;
  late ImageProvider image;
  FriendsprofilepictureCubit({required this.uid}) : super(FriendsprofilepictureInitial()){
    retriveimage();
  }

  void retriveimage() async{
    final path = 'ProfilePictures/${this.uid}';
    String link;
    try{
      link = await FirebaseStorage.instance.ref().child(path).getDownloadURL();
      emit(Retrivedprofilepicture(url: link));
    }
    catch(Exception){
    }
  }
}
