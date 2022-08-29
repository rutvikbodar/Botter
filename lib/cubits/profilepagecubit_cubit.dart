import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_compression_flutter/flutter_image_compress.dart';
import 'package:image_compression_flutter/image_compression_flutter.dart';
import 'package:meta/meta.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import '../database/database.dart';
part 'profilepagecubit_state.dart';


class ProfilepagecubitCubit extends Cubit<ProfilepagecubitState> {
  databaseservice db;
  ProfilepagecubitCubit({required this.db}) : super(ProfilepagecubitInitial()){
    profilepictureprovider();
  }

  Future<void> selectfile() async{
    final ImagePicker imagepicker = ImagePicker();
    final XFile? image = await imagepicker.pickImage(source: ImageSource.gallery);
    CroppedFile? croppedFile = await ImageCropper().cropImage(
      sourcePath: image!.path,
      aspectRatioPresets: [
        CropAspectRatioPreset.square,
      ],
      uiSettings: [
        AndroidUiSettings(
            toolbarTitle: 'Cropper',
            toolbarColor: Colors.deepOrange,
            toolbarWidgetColor: Colors.white,
            initAspectRatio: CropAspectRatioPreset.square,
            lockAspectRatio: true),
        IOSUiSettings(
          title: 'Cropper',
          aspectRatioLockEnabled: true,
          minimumAspectRatio: 1
        ),
      ],
    );
    final file = File(croppedFile!.path);
    final path = 'ProfilePictures/${db.uid}';
    final ref = FirebaseStorage.instance.ref().child(path);
    await ref.putFile(file);
    await profilepictureprovider();
  }

  Future<void> profilepictureprovider() async{
    final path = 'ProfilePictures/${db.uid}';
    String url = await FirebaseStorage.instance.ref().child(path).getDownloadURL();
    emit(Profilepageretrived(url: url));
  }
}
