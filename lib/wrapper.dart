import 'package:botter/home.dart';
import 'package:botter/loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import './user.dart';
import 'auth.dart';
import 'createusername.dart';
import 'cubits/username_cubit.dart';

class wrapper extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    final use = Provider.of<user?>(context);
    if(use==null){
      return auth();
    }
    else{
      UsernameState uns = (context).watch<UsernameCubit>().state;
      if(uns.username=="waiting"){
        return loading();
      }
      else{
        if(uns.iscreated) return home();
        else return createusername();
      }
    }
  }
}