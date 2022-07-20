import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_template/bloc/login/login_cubit.dart';
import 'package:flutter_template/ui/components/button.dart';
import 'package:flutter_template/ui/screens/home/home_navigator.dart';
import 'package:flutter_template/ui/themes/text_styles.dart';

class LoginWidget extends StatefulWidget {
  const LoginWidget({Key? key}) : super(key: key);

  @override
  State<LoginWidget> createState() => _LoginWidgetState();
}

class _LoginWidgetState extends State<LoginWidget> {
  final _formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  void handleLogin(BuildContext context) {
    context
        .read<LoginCubit>()
        .login(emailController.text, passwordController.text);
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
    return Scaffold(
        appBar: AppBar(title: const Text('Flutter Template')),
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
                              const Text("Email", style: textH5),
                              const SizedBox(height: 5),
                              TextField(
                                controller: emailController,
                                decoration: const InputDecoration(
                                    hintStyle: TextStyle(fontSize: 16),
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(16))),
                                    hintText: "Write your email address"),
                                style: textInput,
                              ),
                              const SizedBox(height: 15),
                              const Text("Password", style: textH5),
                              const SizedBox(height: 5),
                              TextField(
                                controller: passwordController,
                                decoration: const InputDecoration(
                                    hintStyle: TextStyle(fontSize: 16),
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(16))),
                                    hintText: "Write your password"),
                                style: textInput,
                                obscureText: true,
                              ),
                            ]))
                  ]),
                  Column(
                    children: [
                      if (state is LoginFailure)
                        const Text("Please write an email and a password",
                            style: textSmall),
                      Button(
                          isLoading: state is LoginLoading,
                          text: "Log in",
                          onPressed: () => handleLogin(context)),
                    ],
                  ),
                ]),
          );
        }));
  }
}
