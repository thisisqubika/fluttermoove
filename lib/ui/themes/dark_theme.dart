import 'package:flutter/material.dart';
import 'package:flutter_template/ui/themes/text_styles.dart';

Color brandingPrimaryColor = const Color(0xff0a0a36);

ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    primaryColor: brandingPrimaryColor,
    primaryColorDark: Colors.blueAccent,
    primaryColorLight: Colors.lightBlueAccent,
    disabledColor: Colors.blueGrey,
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      foregroundColor: Colors.white,
    ),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: Colors.black,
    ),
    iconTheme: const IconThemeData(
      color: Colors.white,
    ),
    scaffoldBackgroundColor: Colors.grey.shade900,
    indicatorColor: Colors.white,
    shadowColor: Colors.grey.shade900,
    fontFamily: fontFamily,
    textTheme: const TextTheme(
      headline1: textH1,
      headline4: textH4,
      headline5: textH5,
      subtitle1: textStandard,
      subtitle2: textSmall,
      bodyText1: textInput,
    ),
    appBarTheme: AppBarTheme(
      backgroundColor: Colors.grey.shade900,
      foregroundColor: Colors.white,
      elevation: 0,
    ));
