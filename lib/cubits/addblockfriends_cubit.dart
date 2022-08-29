import 'package:bloc/bloc.dart';
import 'package:botter/database/database.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';
part 'addblockfriends_state.dart';

class AddblockfriendsCubit extends Cubit<AddblockfriendsState> {
  databaseservice db;
  AddblockfriendsCubit({required this.db}) : super(AddblockfriendsInitial());

  void addfriend(String ownuid,String p2uid,String ownusername,String p2username,bool isperson) async{
    await db.friends.doc(ownuid).update({
      "friendslist" : FieldValue.arrayUnion([{
        "username" : p2username,
        "uid" : p2uid,
        "isperson" : isperson
      }]),
    });
    await db.friends.doc(p2uid).update({
      "friendslist" : FieldValue.arrayUnion([{
        "username" : ownusername,
        "uid" : ownuid,
        "isperson" : isperson
      }]),
    });
    await db.createinitialchat(ownusername, p2username,ownuid,p2uid);
  }
}
