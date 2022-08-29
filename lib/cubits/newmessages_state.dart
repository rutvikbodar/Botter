part of 'newmessages_cubit.dart';

class NewmessagesState {
  int newmessages;
  late Widget icon;
  NewmessagesState({required this.newmessages}){
    if(this.newmessages>999){
      newmessages = 999;
    }
    icon = Container(
      height: 20,
      width: 20,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),color: (newmessages==0)?Colors.transparent:Colors.green),
      child: Center(child: Text(newmessages.toString(),style: TextStyle(color: (newmessages==0)?Colors.transparent:Colors.white,fontWeight: FontWeight.bold,fontSize: 10),)),
    );
  }
}

