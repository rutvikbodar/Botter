import 'package:bloc/bloc.dart';
import 'package:botter/database/database.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
part '../cubits/setusername_state.dart';

class SetusernameCubit extends Cubit<SetusernameState> {
  databaseservice db;
  SetusernameCubit({required this.db}) : super(SetusernameState()) {
}
  void tryaddinguser(String username,bool iscreated) async {
    if(iscreated) return;
    DocumentSnapshot ds = await db.usernames.doc("usernames").get();
    List list = ds.get("usernames");
    if(list.contains(username)){
      emit(setresult(status: "username already taken!"));
    }
    else{
      await db.isusernamecreated.doc(db.uid).set({
        "iscreated" : true,
        "username" : username,
      });
      await db.usernames.doc("usernames").update({
        "usernames" : FieldValue.arrayUnion([{
          "username" : username,
          "uid" : db.uid,
          "isperson" : true
        }])
      });
      emit(success());
    }
  }
}

