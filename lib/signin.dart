import 'package:botter/service.dart';
import 'package:flutter/material.dart';
import './loading.dart';
class signin extends StatefulWidget {
final Function? toggle;
signin({this.toggle});
  @override
  _signinState createState() => _signinState();
}

class _signinState extends State<signin> {
  final Authservice _auth = Authservice();
  String email = '';
  String password = '';
  bool loads = false;
  @override
  Widget build(BuildContext context) {
    return loads ? loading() : Scaffold(
      backgroundColor: Color(0xff1b3239),
      appBar: AppBar(
        backgroundColor: Color(0xff1b3239),
        actions: <Widget>[
          Container(
            margin: EdgeInsets.fromLTRB(0, 10, 45, 15),
            child: Text(
              "Sign in",
              style: TextStyle(
                color: Colors.white,fontSize: 27,
                fontWeight: FontWeight.bold,

              ),
            ),
          ),
          FlatButton.icon(onPressed: ()  {
            widget.toggle!();
          }, icon: Icon(Icons.person), label: Text("register",style: TextStyle(color: Colors.white),)),

        ],
      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 50,horizontal: 50
      ),
    child: Center(
      child: Form(child: Column(
        children: <Widget>[
          SizedBox(height: 20,),
          TextFormField(style: TextStyle(color: Colors.white),
            decoration: new InputDecoration.collapsed(hintText: "enter your email address",focusColor: Colors.white,hoverColor: Colors.white,hintTextDirection: TextDirection.ltr,hintStyle: TextStyle(color: Colors.white),fillColor: Colors.white),
            onChanged: (val){
              setState(() {
                email = val;
              });
            },),
            SizedBox(height: 20),
          TextFormField(style: TextStyle(color: Colors.white),
            decoration: new InputDecoration.collapsed(hintText: "enter your password",hintStyle: TextStyle(color: Colors.white)),
            obscureText: true,
            onChanged: (val){
              setState(() {
                password = val;
              });
            },),
          SizedBox(height: 20,),
          FlatButton(
            shape: (RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0),
              side: BorderSide(color: Colors.red))
            ),
            color: Colors.orangeAccent,
            child: Text("sign in",style: TextStyle(color: Colors.white),),
            onPressed:() async{
              setState(() {
                loads = true;
              });
              dynamic result = await _auth.signinwitheandp(email,password);
              if(result==null){
                setState(() {
                  loads = false;
                });

              }
              else{
                null;
              }
            },

          )

        ],
      )),
    )
    ));
  }
}
