import 'package:flutter/material.dart';

class ThemeProvider extends ChangeNotifier {
  bool _isDarkMode = false;

  bool get isDarkMode => _isDarkMode;

  ThemeMode get themeMode => _isDarkMode ? ThemeMode.dark : ThemeMode.light;

  void toggleTheme() {
    _isDarkMode = !_isDarkMode;
    notifyListeners();
    // TODO: Save preference to SharedPreferences
  }

  void setTheme(bool isDark) {
    _isDarkMode = isDark;
    notifyListeners();
    // TODO: Save preference to SharedPreferences
  }

  // TODO: Load saved theme preference from storage
  void loadThemePreference() {
    // Implementation will be added when we integrate SharedPreferences
  }
}