import 'package:flutter/material.dart';
class MyTheme {
  static Color primeLight = Color(0xff5D9CEC);
  static Color bgLight = Color(0xffdfecdb);
  static Color DarkbgLight = Color(0xff060e1e);
  static Color redCplor = Color(0xffec4b4b);
  static Color whiteColor = Color(0xffffffff);
  static Color DarkColor = Color(0xff141922);
  static Color blackColor = Color(0xff000000);
  static Color grayColor = Color(0xffc8c9cb);
  static Color greenColor = Color(0xff61e757);
  static ThemeData LightTheme = ThemeData(
    primaryColor: primeLight,
    scaffoldBackgroundColor: bgLight,
    textTheme: TextTheme(
        titleLarge: TextStyle(
        color: blackColor,
        fontSize: 22,
        fontWeight: FontWeight.bold
      ),
        titleMedium: TextStyle(
            color: blackColor,
            fontSize: 20,
            fontWeight: FontWeight.w700
        ),
        titleSmall: TextStyle(
            color: blackColor,
            fontSize: 18,
            fontWeight: FontWeight.w400
        )
    ),
    appBarTheme: AppBarTheme(
      elevation: 0,
      color: primeLight
  ),

  );
  static ThemeData DarkTheme = ThemeData(
    primaryColor: primeLight,
    scaffoldBackgroundColor: DarkbgLight,
    textTheme: TextTheme(
        titleLarge: TextStyle(
            color: whiteColor,
            fontSize: 22,
            fontWeight: FontWeight.bold
        ),
        titleMedium: TextStyle(
            color: whiteColor,
            fontSize: 20,
            fontWeight: FontWeight.w700
        ),
        titleSmall: TextStyle(
            color: whiteColor,
            fontSize: 18,
            fontWeight: FontWeight.w400
        )
    ),
    appBarTheme: AppBarTheme(
        elevation: 0,
        color: primeLight
    ),

  );

}