import 'package:flutter/material.dart';
import 'package:music_player/constants/colors.dart';

class AppTheme {
  static ThemeData theme = ThemeData(
      scaffoldBackgroundColor: bgDarkColor,
      appBarTheme:
          const AppBarTheme(backgroundColor: Colors.transparent, elevation: 0));
}
