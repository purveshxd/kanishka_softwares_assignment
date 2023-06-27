import 'package:flutter/material.dart';

class Style {
  static ThemeData themeData(bool isDarkTheme, BuildContext context) {
    if (isDarkTheme) {
      return ThemeData.dark(useMaterial3: true);
    } else {
      return ThemeData.light(useMaterial3: true);
    }
  }
}
