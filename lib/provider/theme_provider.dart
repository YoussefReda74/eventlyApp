import 'package:flutter/material.dart';

class MyProvider extends ChangeNotifier {
  ThemeMode thememode = ThemeMode.light;

  void changetheme(ThemeMode newTheme) {
    thememode = newTheme;
    notifyListeners();
  }


}
