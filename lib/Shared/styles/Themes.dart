import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'colors.dart';

ThemeData darkTheme = ThemeData(
    primaryColor: defaultColor,
    primaryColorDark: Colors.black,
    primaryColorLight: Colors.grey[900],
    colorScheme: const ColorScheme(
      brightness: Brightness.dark,
      primary: defaultColor,
      onPrimary: defaultColor,
      secondary: defaultColor,
      onSecondary: defaultColor,
      error: Colors.red,
      onError: Colors.red,
      background: Colors.white12,
      onBackground: Colors.white12,
      surface: Colors.white,
      onSurface: Colors.white,
    ),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: defaultColor,
    ),
    scaffoldBackgroundColor: Colors.white12,
    appBarTheme: const AppBarTheme(
        scrolledUnderElevation: 0.0,
        elevation: 0,
        backgroundColor: Colors.white12,
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: Colors.white12,
          statusBarIconBrightness: Brightness.light,
        ),
        titleTextStyle: TextStyle(
          fontFamily: 'Jannah',
          color: Colors.white,
          fontSize: 25.0,
          fontWeight: FontWeight.bold,
        ),
        iconTheme: IconThemeData(
            color: Colors.white,
            size: 28.0
        )
    ),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: Colors.white24,
      unselectedItemColor:Colors.white ,
      type: BottomNavigationBarType.fixed,
      selectedItemColor: defaultColor,
      elevation: 20.0,
    ),
    textTheme:  const TextTheme(
        bodyLarge: TextStyle(
            fontSize: 17.0,
            fontWeight: FontWeight.w400,
            color: Colors.white
        ),
      bodyMedium: TextStyle(
          fontSize: 15.0,
          height: 1,
          color: Colors.white
      ),
    ),
  fontFamily: 'Jannah',
  iconTheme: const IconThemeData(
    color: Colors.white
  )
) ;



ThemeData lightTheme =  ThemeData(
    primaryColor: Colors.white,
    primaryColorDark: Colors.white,
    primaryColorLight: Colors.white,
    colorScheme: const ColorScheme(
      brightness: Brightness.light,
      primary: defaultColor,
      onPrimary: defaultColor,
      secondary: defaultColor,
      onSecondary: defaultColor,
      error: Colors.red,
      onError: Colors.red,
      background: Colors.white,
      onBackground: Colors.white,
      surface: Colors.black,
      onSurface: Colors.black,
    ),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: defaultColor,
    ),
    scaffoldBackgroundColor: Colors.grey[50],
    appBarTheme: const AppBarTheme(
        scrolledUnderElevation: 0.0,
        elevation: 0,
        backgroundColor: Colors.white,
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: Colors.white60,
          statusBarIconBrightness: Brightness.dark,
        ),
        titleTextStyle: TextStyle(
          fontFamily: 'Jannah',
          color: Colors.black,
          fontSize: 25.0,
          fontWeight: FontWeight.bold,
        ),
        iconTheme: IconThemeData(
            color: Colors.black,
            size: 28.0
        )
    ),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: Colors.white,
      unselectedItemColor:Colors.black ,
      type: BottomNavigationBarType.fixed,
      selectedItemColor: defaultColor,
      elevation: 20.0,
    ),
    textTheme:  const TextTheme(
      bodyLarge: TextStyle(
          fontSize: 15.0,
          fontWeight: FontWeight.w600,
          color: Colors.black
      ),
      bodyMedium: TextStyle(
          fontSize: 15.0,
          height: 1,
          color: Colors.black
      ),
    ),
    fontFamily: 'Jannah',
    iconTheme: const IconThemeData(
        color: Colors.black
    )
) ;