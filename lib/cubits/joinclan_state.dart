part of 'joinclan_cubit.dart';

abstract class JoinclanState {
  String status = "";
  Color textcolor = Colors.white;
}

class JoinclanInitial extends JoinclanState {
  @override
  String status = "Please Enter the password";
  @override
  Color textcolor = Colors.white;
}

class JoinclanResultState extends JoinclanState{
  @override
  late String status;
  @override
  late Color textcolor;
  JoinclanResultState({required this.status,required this.textcolor});
}
