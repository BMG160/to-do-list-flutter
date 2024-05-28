import 'package:flutter/material.dart';
import 'package:to_do_list/theme/theme.dart';

class ThemeBloc extends ChangeNotifier{
  ThemeData _themeData = lightMode;
  bool light = false;

  ThemeData get getThemeData => _themeData;
  bool get getLight => light;

  void toggleTheme(){
    light = !light;
    if(_themeData == lightMode){
      _themeData = darkMode;
    } else {
      _themeData = lightMode;
    }
    notifyListeners();
  }

}