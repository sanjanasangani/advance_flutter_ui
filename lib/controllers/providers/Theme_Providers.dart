import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../Models/Theme_Modals.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeModel themeModel;
  ThemeProvider({
    required this.themeModel,
});

  ChangeTheme() async {
    themeModel.isDark = !themeModel.isDark;

    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isDark', themeModel.isDark);

    notifyListeners();
  }
}

