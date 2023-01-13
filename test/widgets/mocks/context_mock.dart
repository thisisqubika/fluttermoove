import 'package:flutter/material.dart';
import 'package:flutter_template/constants/l10n/localizations.dart';
import 'package:flutter_template/ui/themes/dark_theme.dart';
import 'package:flutter_template/ui/themes/light_theme.dart';

class ContextMock extends StatelessWidget {
  final Widget child;

  const ContextMock({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: localizationDelegates,
      supportedLocales: supportedLocales,
      locale: currentLanguage,
      theme: lightTheme,
      darkTheme: darkTheme,
      themeMode: ThemeMode.light,
      home: child,
    );
  }
}
