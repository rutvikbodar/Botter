import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'database/generator.dart';

class messagetile extends StatefulWidget {
  String currentuser;
  Map<String,dynamic> data;
  messagetile({required this.currentuser,required this.data});
  @override
  State<messagetile> createState() => _messagetileState();
}

class _messagetileState extends State<messagetile> with generatedatetime {
  @override
  Widget build(BuildContext context) {
    Timestamp timestamp = widget.data["timestamp"];
    return Align(
      alignment: (widget.currentuser==widget.data["from"]?Alignment.centerRight:Alignment.centerLeft),
      child: UnconstrainedBox(
        child: Column(
          crossAxisAlignment: (widget.currentuser==widget.data["from"]?CrossAxisAlignment.end:CrossAxisAlignment.start),
          children: [
            (widget.data["text"]!="##heart-#")
                ?
            Container(
              constraints: BoxConstraints(
                maxWidth: 280,
                minHeight: 40,
                minWidth: 60
              ),
              decoration: BoxDecoration(
                color: Colors.red,
                borderRadius: BorderRadius.circular(20)
              ),
              padding: EdgeInsets.all(10),
              child: Text(
                widget.data["text"],
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                ),
              ),
            )
            :
            Icon(Icons.favorite,color: Colors.yellow,size: 40),
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
