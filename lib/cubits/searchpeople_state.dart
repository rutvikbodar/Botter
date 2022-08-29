part of 'searchpeople_cubit.dart';

class SearchpeopleState {}

class InitialsearchState extends SearchpeopleState{
}

class SearchresultState extends SearchpeopleState{
  List<Map<String,dynamic>> list;
  SearchresultState({required this.list});

  List<Widget> generatesearchtiles(Color devidercolor){
    List<Widget> lis = List<Widget>.empty(growable: true);
    for(Map<String,dynamic> s in list){
      lis.add(Container(
        height: 0.5,
        color: devidercolor,
      ));
      lis.add(SearchListTile(usernamemap: s));
    }
    return lis;
  }

}

class NouserFound extends SearchpeopleState{
}
