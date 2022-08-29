import 'package:cloud_firestore/cloud_firestore.dart';
import '../user.dart';
import 'package:botter/database/generator.dart';
class databaseservice{
  final CollectionReference isusernamecreated = FirebaseFirestore.instance.collection('isusernamecreated');
  final CollectionReference usernames = FirebaseFirestore.instance.collection('usernames');
  final CollectionReference friends = FirebaseFirestore.instance.collection('friends');
  final CollectionReference chat = FirebaseFirestore.instance.collection('chat');
  final CollectionReference clans = FirebaseFirestore.instance.collection('clans');
  final CollectionReference clanchats = FirebaseFirestore.instance.collection('clanchats');
  final String? uid;
  databaseservice({this.uid});
  Future updateuserdata(String uid,bool iscreated,String username) async{
    await isusernamecreated.doc(uid).set({
      "iscreated" : iscreated,
      "username" : username,
    });
  }
  Future createfriendsentity(String uid) async{
    List<Map<String,dynamic>> friendslist = List<Map<String,dynamic>>.empty(growable: true);
    List<Map<String,dynamic>> blocklist = List<Map<String,dynamic>>.empty(growable: true);
    await friends.doc(uid).set({
      "friendslist" : friendslist,
      "blocklist" : blocklist
    });
  }
  Future createinitialchat(String username1,String username2,String uid1,String uid2) async{
    generator g = generator();
    String chatpath = g.generateid(uid1, uid2);
    List<Map<String,dynamic>> Chat = [{
      "text" : "Hey!",
      "timestamp" : DateTime.now(),
      "isano" : false,
      "from" : username1,
    }];
    await chat.doc(chatpath).set({
      "user1" : username1,
      "user1score" : 1,
      "user2score" : 0,
      "user2" : username2,
      "oldchatlengthuser1" : 1,
      "oldchatlengthuser2" : 0,
      "chat" : Chat,
      "lasttexttime" : DateTime.now()
    });
  }
  userData userfromsnap(DocumentSnapshot snapshot){
    return userData(
      iscreated: snapshot.get("iscreated"),
      username: snapshot.get("username")
    );
  }
  Stream<userData> get userdata{
    return isusernamecreated.doc(uid).snapshots().map(userfromsnap);
  }
}
