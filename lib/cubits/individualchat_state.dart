part of 'individualchat_cubit.dart';

class IndividualchatState {
  bool isperson;
  late List<Map<String,dynamic>> chat;
  late List<Widget> messagetiles = List<Widget>.empty(growable: true);
  DocumentSnapshot? snap;
  String currentuser;
  IndividualchatState({required this.chat,required this.currentuser,required this.isperson,this.snap}){
    for(Map<String,dynamic> s in chat){
      if(isperson){
        messagetiles.add(messagetile(currentuser: currentuser, data: s));
      }
      else{
        messagetiles.add(groupmessagetile(currentuser: currentuser, data: s));
      }
    }
    messagetiles=messagetiles.reversed.toList();
  }
}

