import 'package:flutter/material.dart';

class AppThemes {
  static ThemeData lightTheme = ThemeData.from(
    useMaterial3: true,
    colorScheme: ColorScheme.fromSeed(
      seedColor: Colors.blueAccent,
      primary: Colors.blue,
      brightness: Brightness.light,
      //background: Colors.blue.shade900,
    ),
  );
  static ThemeData darkTheme = ThemeData.from(
    useMaterial3: true,
    colorScheme: ColorScheme.fromSeed(
        seedColor: Colors.black,
        primary: Colors.purple,
        brightness: Brightness.dark,
        secondary: Colors.black
      //background: Colors.lightBlue,
    ),
  );
}
