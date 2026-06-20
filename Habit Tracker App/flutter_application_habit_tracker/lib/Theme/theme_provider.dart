import 'package:flutter/material.dart';
import 'dark_mode.dart';
import 'light_mode.dart';

class ThemeProvider extends ChangeNotifier {
  // Initialize with light mode by default
  ThemeData _themeData = lightMode;

  // Getter for the current theme data
  ThemeData get themeData => _themeData;

  // Method to check if the current theme is dark mode
  bool get isDarkMode => _themeData == darkMode;

  // Method to set the theme data and notify listeners
  void updateTheme(ThemeData theme) {
      _themeData = theme;
      notifyListeners();
  }

  // Method to toggle between light and dark mode
  void toggleTheme() {
    if (_themeData == lightMode) {
      _themeData = darkMode;
    } else {
      _themeData = lightMode;
    }
    notifyListeners();
  }
}