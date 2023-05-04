import 'package:flutter/material.dart';

class AppThemes {
  static ThemeData lightTheme = ThemeData.from(
    useMaterial3: true,
    colorScheme: ColorScheme.fromSeed(
      seedColor: Colors.blueAccent,
      brightness: Brightness.light,
      primary: Colors.blueGrey,
      //background: Colors.blue.shade900,
    ),
  );
  static ThemeData darkTheme = ThemeData.from(
    useMaterial3: true,
    colorScheme: ColorScheme.fromSeed(
      seedColor: Colors.blueAccent,
      brightness: Brightness.dark,
      primary: Colors.blueGrey,
      //background: Colors.lightBlue,
    ),
  );
}
