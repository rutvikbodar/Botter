import 'package:botter/register.dart';
import 'package:botter/signin.dart';
import 'package:flutter/material.dart';

class auth extends StatefulWidget{
  authState createState() => authState();
}
class authState extends State<auth>{
  bool showsignin = true;
  void toggle(){
    setState(() {
      showsignin = !showsignin;
    });
  }
  @override
  Widget build(BuildContext context) {
    if(showsignin){
      return signin(toggle : toggle);
    }
    else{
      return register(toggle : toggle);
    }
  }
}