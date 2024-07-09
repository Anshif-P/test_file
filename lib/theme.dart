import 'package:flutter/material.dart';

class ThemeProvider extends ChangeNotifier {
  bool _isDarkMode = false;
  bool get isDarkMode => _isDarkMode;
  toggleTheme() {
    _isDarkMode = !_isDarkMode;
    notifyListeners();
  }
}

ThemeData lightTheme = ThemeData(
  primaryColor: Colors.grey,
);
ThemeData darkTheme = ThemeData(
  primaryColor: Colors.grey,
);
