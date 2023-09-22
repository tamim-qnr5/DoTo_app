import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AppConfigProvider extends ChangeNotifier{
  String appLang = 'en';
  ThemeMode appMode = ThemeMode.light;
  void changeLang(String newLang){
    if(appLang == newLang){
      return;
    }
    appLang = newLang;
    notifyListeners();
  }
  void changeMode(ThemeMode newMode){
    if(appMode == newMode){
      return;
    }
    appMode = newMode;
    notifyListeners();
  }
}