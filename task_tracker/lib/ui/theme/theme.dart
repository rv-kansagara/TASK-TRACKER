import 'package:flutter/material.dart';

import '../constants/constants.dart';

final darkTheme = ThemeData(
  primarySwatch: Colors.deepOrange,
  primaryColor: kPrimaryColor,
  accentColor: kAccentColor,
  scaffoldBackgroundColor: kScaffoldBackgroundColor,
  brightness: Brightness.dark,
  fontFamily: 'Acme',
  appBarTheme: const AppBarTheme(elevation: 0, centerTitle: true),
);

final lightTheme = ThemeData(
  primarySwatch: Colors.deepOrange,
  primaryColor: Colors.white,
  accentColor: kAccentColor,
  scaffoldBackgroundColor: Colors.grey[100],
  brightness: Brightness.light,
  fontFamily: 'Acme',
  appBarTheme: AppBarTheme(
    elevation: 0,
    centerTitle: true,
    color: Colors.grey[100],
  ),
);
