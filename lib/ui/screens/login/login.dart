import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_template/constants/assets.dart';
import 'package:flutter_template/providers/login/login_provider.dart';
import 'package:flutter_template/providers/login/login_state.dart';
import 'package:flutter_template/ui/components/button.dart';
import 'package:flutter_template/ui/screens/home/home_navigator.dart';
import 'package:flutter_template/ui/themes/text_styles.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LoginWidget extends ConsumerStatefulWidget {
  const LoginWidget({Key? key}) : super(key: key);

  @override
  ConsumerState<LoginWidget> createState() => _LoginWidgetState();
}

class _LoginWidgetState extends ConsumerState<LoginWidget> {
  final _formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  bool emptyFieldsError = false;

  void handleLogin(BuildContext context) {
    bool areFieldsEmpty =
        emailController.text.isEmpty || passwordController.text.isEmpty;

    setState(() => emptyFieldsError = areFieldsEmpty);

    if (!areFieldsEmpty) {
      ref
          .read(loginProvider.notifier)
          .login(emailController.text, passwordController.text);
    }
  }

  void handleLoginSuccess(BuildContext context) {
    Navigator.pushReplacement(context,
        MaterialPageRoute(builder: (ctx) => const HomeNavigatorWidget()));
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final locale = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    final LoginState loginState = ref.watch(loginProvider);

    ref.listen<LoginState>(loginProvider, (LoginState? _, LoginState state) {
      if (state.isUserAuthenticated) {
        handleLoginSuccess(context);
      }
    });

    return Scaffold(
        appBar: AppBar(title: Text(locale.loginTitle)),
        body: Container(
            padding: EdgeInsets.all(20.h),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: 40.h),
                    child: SvgPicture.asset(logoSvgFilePath,
                        height: 60.h, width: 60.h, color: theme.primaryColor),
                  ),
                  Column(children: [
                    Form(
                        key: _formKey,
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(locale.email, style: textH5),
                              const SizedBox(height: 5),
                              TextField(
                                controller: emailController,
                                decoration: InputDecoration(
                                    hintStyle: const TextStyle(fontSize: 16),
                                    border: const OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(16))),
                                    hintText: locale.emailPlaceholder),
                                style: textInput,
                              ),
                              const SizedBox(height: 15),
                              Text(locale.password, style: textH5),
                              const SizedBox(height: 5),
                              TextField(
                                controller: passwordController,
                                decoration: InputDecoration(
                                    hintStyle: const TextStyle(fontSize: 16),
                                    border: const OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(16))),
                                    hintText: locale.passwordPlaceholder),
                                style: textInput,
                                obscureText: true,
                              ),
                            ]))
                  ]),
                  Column(
                    children: [
                      if (loginState.error != null)
                        Text(locale.loginError, style: textSmall),
                      if (emptyFieldsError)
                        Text(locale.emptyFieldsError, style: textSmall),
                      Button(
                          isLoading: loginState.isLoading,
                          text: locale.login,
                          onPressed: () => handleLogin(context)),
                    ],
                  ),
                ])));
  }
}
