import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_template/bloc/login/login_cubit.dart';
import 'package:flutter_template/ui/components/button.dart';
import 'package:flutter_template/ui/screens/home/home_navigator.dart';
import 'package:flutter_template/ui/themes/text_styles.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class LoginWidget extends StatefulWidget {
  const LoginWidget({Key? key}) : super(key: key);

  @override
  State<LoginWidget> createState() => _LoginWidgetState();
}

class _LoginWidgetState extends State<LoginWidget> {
  final _formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  bool emptyFieldsError = false;

  void handleLogin(BuildContext context) {
    bool areFieldsEmpty =
        emailController.text.isEmpty || passwordController.text.isEmpty;

    setState(() => emptyFieldsError = areFieldsEmpty);

    if (!areFieldsEmpty) {
      context
          .read<LoginCubit>()
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

    return Scaffold(
        appBar: AppBar(title: Text(locale.loginTitle)),
        body: BlocConsumer<LoginCubit, LoginState>(listener: (context, state) {
          if (state is LoginSuccess) {
            handleLoginSuccess(context);
          }
        }, builder: (context, state) {
          return Container(
            padding: const EdgeInsets.all(30),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const SizedBox(height: 0),
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
                      if (state is LoginFailure)
                        Text(locale.loginError, style: textSmall),
                      if (emptyFieldsError)
                        Text(locale.emptyFieldsError, style: textSmall),
                      Button(
                          isLoading: state is LoginLoading,
                          text: locale.login,
                          onPressed: () => handleLogin(context)),
                    ],
                  ),
                ]),
          );
        }));
  }
}
