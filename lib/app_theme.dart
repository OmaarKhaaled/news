import 'package:flutter/material.dart';

class AppTheme {
  static const Color gray = Color(0xffA0A0A0);
  static const Color black = Color(0xff171717);
  static const Color white = Color(0xffFFFFFF);

  static ThemeData lightTheme = ThemeData();

  static ThemeData darkTheme = ThemeData(
    scaffoldBackgroundColor: black,
    appBarTheme: AppBarTheme(
      centerTitle: true,
      backgroundColor: black,
      foregroundColor: white,
      titleTextStyle: TextStyle(
        fontSize: 22,
        color: white,
        fontWeight: FontWeight.w500,
      ),
    ),
    textTheme: TextTheme(
      titleLarge: TextStyle(
        fontSize: 24,
        color: white,
        fontWeight: FontWeight.w500,
      ),
    ),
  );
}
