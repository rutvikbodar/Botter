import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter/material.dart';
class  loading extends StatelessWidget {
@override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.orange[500],
      child: Center(
        child: SpinKitSpinningLines(color: Colors.white,size: 50,),
      ),
    );
  }
}
