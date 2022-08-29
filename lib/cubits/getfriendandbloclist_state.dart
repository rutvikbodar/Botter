part of 'getfriendandbloclist_cubit.dart';

class GetfriendandbloclistState {
  String uid;
  late databaseservice db;
  DocumentSnapshot? snap;
  String? searchcode;
  late List<String> friendslist = List<String>.empty(growable: true);
  late List<String> blocklist =  List<String>.empty(growable: true);
  late List<Map<String,dynamic>> friends;
  late List<Map<String,dynamic>> blocks;
  late List<Map<String,dynamic>> sortedfriends;

  GetfriendandbloclistState({required this.uid,required this.friends,required this.blocks,required this.searchcode}){
    db = databaseservice(uid: uid);
    sortedfriends = List<Map<String,dynamic>>.empty(growable: true);
    if(searchcode==null || searchcode!.isEmpty){
      sortedfriends=friends;
    }
    else{
      for(Map<String,dynamic> friend in friends){
        if(friend["username"].toLowerCase().contains(searchcode?.toLowerCase())){
          sortedfriends.add(friend);
        }
      }

    }
    if(friends.isNotEmpty){
      for(Map<String,dynamic> s in friends){
        if(!(s["username"]=="Admin")){
          friendslist.add(s["username"].toString());}
      }
    }
    for(Map<String,dynamic> s in friends){
      friendslist.add(s["username"].toString());
    }
    for(Map<String,dynamic> s in blocks){
      friendslist.add(s["username"].toString());
    }
  }

  Icon friendblockiconprovider(String username,Color iconcolor){
    if(snap==null) return Icon(Icons.check_box_outline_blank,color: Colors.transparent,);
    if(friendslist.contains(username) && !blocklist.contains(username)){
      return Icon(Icons.favorite_outlined,color: Colors.red,);
    }
    else if(blocklist.contains(username)){
      return Icon(Icons.warning_amber_sharp,color: Colors.yellowAccent,);
    }
    else{
      return Icon(Icons.person_add_alt_1_outlined,color: iconcolor,);
    }
  }

  List<Widget> chattilelistprovider(Function fun){
    List<Widget> chattilelist = List<chattile>.empty(growable: true);
    if(friends.isEmpty) return chattilelist;
    AppThemeCubit theme = AppThemeCubit();
    for(Map<String,dynamic> s in sortedfriends){
      chattilelist.add(chattile(ownuid: db.uid.toString(), frienddata: s,color: theme.state.textcolor,fun: fun,key: Key(s["username"]),));
    }
    return chattilelist;
  }

  Map<String,dynamic> toMap(){
    return {
      'uid' : uid,
      'friends' : friends,
      'blocks' : blocks,
    };
  }
  factory GetfriendandbloclistState.fromMap(Map<String,dynamic> map){
    return GetfriendandbloclistState(uid: map["uid"], friends: map["friends"], blocks: map["blocks"], searchcode: "");
  }
}
