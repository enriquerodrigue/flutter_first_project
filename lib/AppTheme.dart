import 'package:flutter/material.dart';

final ThemeData appTheme = ThemeData(
  scaffoldBackgroundColor: Color.fromARGB(143, 158, 158, 158),

  colorScheme: ColorScheme.light().copyWith(
    primary: Colors.red[900], // Sets the primary color
    secondary: Colors.brown[100], // Sets the accent color
));