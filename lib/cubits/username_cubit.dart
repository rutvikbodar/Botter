import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:botter/database/database.dart';
part 'username_state.dart';

class UsernameCubit extends Cubit<UsernameState> {
  late databaseservice db;
  late StreamSubscription streamSubscription;
  UsernameCubit({required this.db}) : super(UsernameState(username: "waiting",iscreated: false)){
    streamSubscription = db.userdata.listen((event) {
      if(!(event.username==null) && !(event.iscreated==null)){
        emit(UsernameState(username: event.username!, iscreated: event.iscreated!));
      }
    });
  }

  void emitdata(UsernameState uns){
    emit(uns);
  }

}
