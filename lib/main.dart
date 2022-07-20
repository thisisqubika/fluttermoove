import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_template/data/repositories/user_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_template/bloc/login/login_cubit.dart';
import 'package:flutter_template/ui/router/routes.dart';
import 'package:flutter/services.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:flutter_template/ui/themes/dark_theme.dart';
import 'package:flutter_template/ui/themes/light_theme.dart';
import 'package:path_provider/path_provider.dart';

Future<void> main() async {
  await dotenv.load();

  final storage = await HydratedStorage.build(
    storageDirectory: await getApplicationSupportDirectory(),
  );

  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
  ));

  final sharedPreferences = await SharedPreferences.getInstance();

  HydratedBlocOverrides.runZoned(
      () => runApp(FlutterTemplateApp(
            appRouter: AppRouter(),
            sharedPreferences: sharedPreferences,
          )),
      storage: storage);
}

class FlutterTemplateApp extends StatelessWidget {
  final AppRouter appRouter;
  final SharedPreferences sharedPreferences;

  const FlutterTemplateApp(
      {Key? key, required this.appRouter, required this.sharedPreferences})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<UserRepository>(
            create: (context) => UserRepository()),
      ],
      child: MultiBlocProvider(
          providers: [
            BlocProvider<LoginCubit>(
                create: (context) =>
                    LoginCubit(repository: context.read<UserRepository>())),
          ],
          child: MaterialApp(
            debugShowCheckedModeBanner: false,
            onGenerateRoute: appRouter.onGenerateRoute,
            theme: lightTheme,
            darkTheme: darkTheme,
            themeMode: ThemeMode.light,
            // localizationsDelegates: localizationDelegates,
            // supportedLocales: locales,
            // locale: const Locale('en', ''),
          )),
    );
  }
}
