import 'package:flutter/material.dart';
import 'package:flutter_template/ui/themes/text_styles.dart';

Color brandingPrimaryColor = const Color(0xff0a0a36);

ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    primaryColor: brandingPrimaryColor,
    primaryColorDark: Colors.blueAccent,
    primaryColorLight: Colors.lightBlueAccent,
    disabledColor: Colors.blueGrey,
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      foregroundColor: Colors.white,
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: Colors.grey.shade300,
    ),
    iconTheme: const IconThemeData(
      color: Colors.blueAccent,
    ),
    scaffoldBackgroundColor: Colors.white,
    indicatorColor: Colors.blueAccent,
    shadowColor: Colors.grey.withOpacity(0.27),
    fontFamily: fontFamily,
    textTheme: const TextTheme(
      headline1: textH1,
      headline4: textH4,
      headline5: textH5,
      subtitle1: textStandard,
      subtitle2: textSmall,
      bodyText1: textInput,
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.white,
      foregroundColor: Colors.black,
      elevation: 0,
    ));
