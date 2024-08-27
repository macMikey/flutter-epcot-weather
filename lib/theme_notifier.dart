import 'package:flutter/material.dart';

class ThemeNotifier with ChangeNotifier {
  ThemeMode _themeMode = ThemeMode.system; // Default to system theme

  ThemeMode get themeMode => _themeMode;

  void toggleTheme(BuildContext context) {
    if (_themeMode == ThemeMode.system) {
      // Toggle to the opposite of the system theme
      final brightness = View.of(context).platformDispatcher.platformBrightness;
      _themeMode = brightness == Brightness.dark ? ThemeMode.light : ThemeMode.dark;
    } else {
      // Toggle back to system theme
      _themeMode = ThemeMode.system;
    }
    notifyListeners();
  }
}
