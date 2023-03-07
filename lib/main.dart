import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_template/constants/l10n/localizations.dart';
import 'package:flutter_template/data/network/http_client.dart';
import 'package:flutter_template/data/repositories/user_repository.dart';
import 'package:flutter_template/services/secure_storage.dart';
import 'package:flutter_template/ui/router/routes.dart';
import 'package:flutter/services.dart';
import 'package:flutter_template/ui/themes/dark_theme.dart';
import 'package:flutter_template/ui/themes/light_theme.dart';

Future<void> main() async {
  await dotenv.load();

  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
  ));

  final sharedPreferences = await SharedPreferences.getInstance();

  // Inject singletons
  await _injectServices();

  runApp(ProviderScope(
      child: FlutterTemplateApp(
    appRouter: AppRouter(),
    sharedPreferences: sharedPreferences,
  )));
  FlutterNativeSplash.remove();
}

final getIt = GetIt.instance;
_injectServices() async {
  // Initialize repositories
  getIt.registerSingleton<UserRepository>(UserRepository());

  // Initialize services
  getIt.registerSingleton<HttpClient>(HttpClient());
  getIt.registerSingleton<SecureStorage>(SecureStorage());
}

class FlutterTemplateApp extends StatelessWidget {
  final AppRouter appRouter;
  final SharedPreferences sharedPreferences;

  const FlutterTemplateApp(
      {Key? key, required this.appRouter, required this.sharedPreferences})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      builder: (BuildContext context, Widget? child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          onGenerateRoute: appRouter.onGenerateRoute,
          theme: lightTheme,
          darkTheme: darkTheme,
          themeMode: ThemeMode.light,
          localizationsDelegates: localizationDelegates,
          supportedLocales: supportedLocales,
          locale: currentLanguage,
        );
      },
    );
  }
}
