import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'colors.dart';

ThemeData themeLight = ThemeData(
  brightness: Brightness.light,
  primarySwatch: primarySwatchLight,
  scaffoldBackgroundColor: white,
  fontFamily: 'Jannah',
  appBarTheme: const AppBarTheme(
    titleSpacing: 20.0,
    systemOverlayStyle: SystemUiOverlayStyle(
      statusBarColor: white,
      statusBarIconBrightness: Brightness.dark,
    ),
    backgroundColor: white,
    elevation: 0.0,
    titleTextStyle: TextStyle(
      color: black,
      fontSize: 20.0,
      fontWeight: FontWeight.bold,
    ),
    iconTheme: IconThemeData(
      color: black,
    ),
  ),
  floatingActionButtonTheme: const FloatingActionButtonThemeData(
    backgroundColor: primarySwatchLight,
  ),
  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
    type: BottomNavigationBarType.fixed,
    selectedItemColor: primarySwatchLight,
    unselectedItemColor: grey,
    elevation: 20.0,
    backgroundColor: white,
  ),
  textTheme: const TextTheme(
    bodyText1: TextStyle(
      fontSize: 18.0,
      fontWeight: FontWeight.w600,
      color: black,
    ),
  ),
);

ThemeData themeDark = ThemeData(
    brightness: Brightness.dark,
    primarySwatch: primarySwatchDark,
    fontFamily: 'Jannah',
    scaffoldBackgroundColor: const Color(0x000517ab),
    appBarTheme: const AppBarTheme(
      titleSpacing: 20.0,
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: Color(0x000517ab),
        statusBarIconBrightness: Brightness.light,
      ),
      backgroundColor: Color(0x000517ab),
      elevation: 0.0,
      titleTextStyle: TextStyle(
        color: white,
        fontSize: 20.0,
        fontWeight: FontWeight.bold,
      ),
      iconTheme: IconThemeData(
        color: white,
      ),
    ));
