import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
part 'sendbutton_state.dart';

class SendbuttonCubit extends Cubit<SendbuttonState> {
  SendbuttonCubit() : super(SendbuttonState(icon: Icon(Icons.favorite,color: Colors.orange,shadows: [Shadow(color: Colors.red,blurRadius: 4)],size: 30),isheart: true));

  void changeintext(String s){
    if(s.trim().isEmpty){
      emit(SendbuttonState(icon: Icon(Icons.favorite,color: Colors.orange,shadows: [Shadow(color: Colors.red,blurRadius: 4)],size: 30),isheart: true));
    }
    else{
      emit(SendbuttonState(icon: Icon(Icons.send_outlined,color: Colors.white,),isheart: false));
    }
  }
}
