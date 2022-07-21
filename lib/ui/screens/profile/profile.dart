import 'package:flutter/material.dart';
import 'package:flutter_template/bloc/login/login_cubit.dart';
import 'package:flutter_template/ui/components/button.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_template/ui/screens/login/login.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ProfileWidget extends StatelessWidget {
  const ProfileWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final locale = AppLocalizations.of(context)!;

    void handleLogout() {
      context.read<LoginCubit>().logout();
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (ctx) => const LoginWidget()));
    }

    return Scaffold(
      appBar: AppBar(title: Text(locale.profile)),
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(locale.profileTitle),
          SizedBox(
              width: 100,
              child: Button(
                text: locale.logout,
                onPressed: handleLogout,
              ))
        ],
      )),
    );
  }
}
