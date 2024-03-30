import 'package:flutter/material.dart';

class ThemeController extends ChangeNotifier {
  bool _darkTheme = false;

  bool get darkTheme => _darkTheme;

  void switchTheme() {
    _darkTheme = !_darkTheme;
    notifyListeners();
  }
}
