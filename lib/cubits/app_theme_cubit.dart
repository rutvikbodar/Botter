import 'dart:ui';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
part 'app_theme_state.dart';

class AppThemeCubit extends Cubit<AppThemeState> {
  AppThemeCubit() : super(AppThemeState(background: Color(0xff1b3239),textcolor: Colors.white));

  void changeapptheme(Color backgroundcolor, Color textcolor){
    emit(AppThemeState(background: backgroundcolor,textcolor: textcolor));
  }
}
