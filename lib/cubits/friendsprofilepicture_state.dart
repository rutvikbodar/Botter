part of 'friendsprofilepicture_cubit.dart';

@immutable
abstract class FriendsprofilepictureState {
  late String url;
}

class FriendsprofilepictureInitial extends FriendsprofilepictureState {
  @override
  String url = "";
}

class Retrivedprofilepicture extends FriendsprofilepictureState{
  @override
  String url;
  Retrivedprofilepicture({required this.url});
}
