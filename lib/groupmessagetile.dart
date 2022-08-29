import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'database/generator.dart';

class groupmessagetile extends StatelessWidget with generatedatetime{
  String currentuser;
  Map<String,dynamic> data;
  groupmessagetile({required this.currentuser,required this.data});
  Widget build(BuildContext context) {
    Timestamp timestamp = data["timestamp"];
    return Align(
      alignment: (currentuser==data["from"]?Alignment.centerRight:Alignment.centerLeft),
      child: UnconstrainedBox(
        child: Column(
          crossAxisAlignment: (currentuser==data["from"]?CrossAxisAlignment.end:CrossAxisAlignment.start),
          children: [
            Container(
              margin: EdgeInsets.only(bottom: 5),
              decoration: BoxDecoration(
                color: Colors.white12,
                borderRadius: BorderRadius.circular(10)
              ),
              child: Column(
                crossAxisAlignment: (currentuser==data["from"]?CrossAxisAlignment.end:CrossAxisAlignment.start),
                children: [
                  Container(
                    margin : EdgeInsets.only(right: 7,left: 7),
                    child: Text(data["from"],style: TextStyle(color: Colors.orange),),
                  ),
                  (data["text"]!="##heart-#")
                      ?
                  Container(
                    constraints: BoxConstraints(
                        maxWidth: 280,
                        minHeight: 40,
                        minWidth: 100
                    ),
                    decoration: BoxDecoration(
                        color: Colors.white12,
                        borderRadius: BorderRadius.circular(10)
                    ),
                    padding: EdgeInsets.all(10),
                    child: Text(
                      data["text"],
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                      ),
                    ),
                  )
                      :
                  Container(margin : EdgeInsets.only(left: 5,right: 5),child: Icon(Icons.favorite,color: Colors.yellow,size: 40)),
                ],
              ),
            ),
            Container(
              child: Text(
                generatedatetime.generatedatetimestring(timestamp),
                style: TextStyle(
                    color: Colors.white70,
                    fontSize: 11
                ),
              ),
              margin: EdgeInsets.only(bottom: 5,left: 8,right: 8),
            )
          ],
        ),
      ),
    );
  }
}
