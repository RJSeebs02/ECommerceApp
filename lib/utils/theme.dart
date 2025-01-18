import 'package:flutter/material.dart';

class AppColors {
  static const Color primary = Color(0xFF4894FE);
  static const Color secondary = Color.fromARGB(255, 255, 255, 255);
  static const Color tertiary = Color.fromARGB(120, 255, 255, 255);
  static const Color h1 = Color.fromARGB(255, 0, 0, 0);
  static const Color h2 = Color.fromARGB(255, 163, 163, 163);
  static const Color defaultText = Color(0xFF8696BB);
  static const Color borderColor = Color.fromARGB(255, 224, 224, 224);
  static const Color secondaryBg = Color(0xFFFAFAFA);
  static const Color logout = Color.fromARGB(255, 255, 96, 96);
}

final ThemeData appTheme = ThemeData(
  fontFamily: 'AfacadFlux',
  primaryColor: AppColors.primary,
  scaffoldBackgroundColor: AppColors.secondary,
  textTheme: const TextTheme(
    headlineLarge: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
    bodyLarge: TextStyle(fontSize: 14),
  ),
  colorScheme: ColorScheme.fromSwatch().copyWith(
    primary: AppColors.primary,
    secondary: AppColors.secondary,
  ),
);
