import 'package:flutter/material.dart';

ThemeData lightMode = ThemeData(
  colorScheme: ColorScheme.light(
    surface: Colors.grey.shade300,
    primary: Colors.grey.shade500,
    secondary: Colors.grey.shade200,
    tertiary: Colors.white,
    inversePrimary: Colors.grey.shade900,
  ),
  appBarTheme: const AppBarTheme(
    backgroundColor: Color.fromARGB(255, 62, 62, 62),
    foregroundColor: Color.fromARGB(255, 210, 203, 203),
  ),
  textTheme: const TextTheme(
    bodyMedium: TextStyle(color: Color.fromARGB(255, 62, 62, 62)),
  ),
);