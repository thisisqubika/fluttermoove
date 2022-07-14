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
  bool _isLoading = false;
  bool _isError = false;

  final _formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  void handleLogin(BuildContext context) {
    _isLoading = false;
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
      body: Container(
        padding: const EdgeInsets.all(10),
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
                            enabled: !_isLoading,
                            controller: emailController,
                            decoration: const InputDecoration(
                                hintStyle: TextStyle(fontSize: 16),
                                border: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(16))),
                                hintText: "Write your email address"),
                            style: textInput,
                          ),
                          const SizedBox(height: 15),
                          const Text("Password", style: textH5),
                          const SizedBox(height: 5),
                          TextField(
                            enabled: !_isLoading,
                            controller: passwordController,
                            decoration: const InputDecoration(
                                hintStyle: TextStyle(fontSize: 16),
                                border: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(16))),
                                hintText: "Write your password"),
                            style: textInput,
                            obscureText: true,
                          ),
                        ]))
              ]),
              if (_isError) const Text("Login error"),
              BlocListener<LoginCubit, LoginState>(
                listener: (context, state) {
                  if (state is LoginLoading) {
                    _isLoading = true;
                    _isError = false;
                  } else if (state is LoginSuccess) {
                    handleLoginSuccess(context);
                  } else if (state is LoginFailure) {
                    _isError = true;
                  } else {
                    _isLoading = false;
                  }
                },
                child: Button(
                    isLoading: _isLoading,
                    text: "Log in",
                    onPressed: () => handleLogin(context)),
              ),
            ]),
      ),
    );
  }
}
