part of 'profilepagecubit_cubit.dart';

@immutable
abstract class ProfilepagecubitState {
  String url = "";
}

class ProfilepagecubitInitial extends ProfilepagecubitState {}

class Profilepageretrived extends ProfilepagecubitState{
  @override
  String url;
  Profilepageretrived({required this.url}){
  }
}
