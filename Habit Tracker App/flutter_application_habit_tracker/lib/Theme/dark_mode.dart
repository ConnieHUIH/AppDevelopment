import 'package:flutter/material.dart';

ThemeData darkMode = ThemeData(
  colorScheme: ColorScheme.dark(
    surface: Colors.grey.shade900,
    primary: Colors.grey.shade600,
    secondary: Colors.grey.shade700,
    tertiary: Colors.grey.shade800,
    inversePrimary: Colors.grey.shade300,
  ),
  appBarTheme: const AppBarTheme(
    backgroundColor: Color.fromARGB(255, 210, 203, 203),
    foregroundColor: Color.fromARGB(255, 62, 62, 62),
  ),
  textTheme: const TextTheme(
    bodyMedium: TextStyle(color: Color.fromARGB(255, 210, 203, 203)),
  ),
);