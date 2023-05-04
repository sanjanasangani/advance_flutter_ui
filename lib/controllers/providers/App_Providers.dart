import 'package:flutter/material.dart';
import 'package:p_converter/Models/App_Models.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppProvider extends ChangeNotifier {
  AppModel appModel;
  AppProvider({required this.appModel});

  changeui() async {
    appModel.switchVal = !appModel.switchVal;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('Switch', appModel.switchVal);
    notifyListeners();
  }
}