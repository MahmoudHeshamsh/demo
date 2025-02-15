import 'package:flutter/material.dart';

class AppTheme {
  static const Color primary = Color(0xFF5D9CEC);
  static const Color backgroundLight = Color(0xFFDFECDB);
  static const Color backgroundDark = Color(0xFF1E1E1E);
  static const Color black = Color(0xFF363636);
  static const Color white = Color(0xFFFFFFFF);
  static const Color green = Color(0xFF61E757);
  static const Color red = Color(0xFFEC4B4B);
  static const Color gray = Color(0xFFA9A9A9);
  static const Color lightgray = Color(0xFFdddddd);

  static ThemeData lightTheme = ThemeData(
    primaryColor: primary,
    scaffoldBackgroundColor: backgroundLight,
    appBarTheme: AppBarTheme(
      backgroundColor: Colors.transparent,
      centerTitle: true
    ),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: white,
      type: BottomNavigationBarType.fixed,
      selectedItemColor: primary,
      unselectedItemColor: gray,
      showSelectedLabels: false,
      showUnselectedLabels: false,
    ),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: primary,
      foregroundColor: white,
      shape: CircleBorder(
        side: BorderSide(
          width: 4,
          color: white
        )
      ),
    ),
    textTheme: const TextTheme(
      titleMedium: TextStyle(
        color: black,
        fontSize: 18,
        fontWeight: FontWeight.bold
      ),
      titleSmall: TextStyle(
        color: black,
        fontSize: 14,
        fontWeight: FontWeight.w400
      ),
      titleLarge: TextStyle(
        color: white,
        fontSize: 14,
        fontWeight: FontWeight.w400
      )
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: primary,
      
      )
    )
  );

  static ThemeData darkTheme = ThemeData(
    primaryColor: primary,
    scaffoldBackgroundColor: backgroundDark,
    appBarTheme: AppBarTheme(
      backgroundColor: Colors.transparent,
      centerTitle: true
    ),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: black,
      type: BottomNavigationBarType.fixed,
      selectedItemColor: primary,
      unselectedItemColor: gray,
      showSelectedLabels: false,
      showUnselectedLabels: false,
    ),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: primary,
      foregroundColor: white,
      shape: CircleBorder(
        side: BorderSide(
          width: 4,
          color: black
        )
      ),
    ),
    textTheme: const TextTheme(
      titleMedium: TextStyle(
        color: white,
        fontSize: 18,
        fontWeight: FontWeight.bold
      ),
      titleSmall: TextStyle(
        color: white,
        fontSize: 14,
        fontWeight: FontWeight.w400
      ),
      titleLarge: TextStyle(
        color: black,
        fontSize: 14,
        fontWeight: FontWeight.w400
      )
    )
  );
}
