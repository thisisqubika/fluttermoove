import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_template/providers/login/login_provider.dart';
import 'package:flutter_template/ui/components/button.dart';
import 'package:flutter_template/ui/screens/login/login.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ProfileWidget extends ConsumerStatefulWidget {
  const ProfileWidget({Key? key}) : super(key: key);

  @override
  ConsumerState<ProfileWidget> createState() => _ProfileWidgetState();
}

class _ProfileWidgetState extends ConsumerState<ProfileWidget> {
  void handleLogout() {
    ref.read(loginProvider.notifier).logout();
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (ctx) => const LoginWidget()));
  }

  @override
  Widget build(BuildContext context) {
    final locale = AppLocalizations.of(context)!;

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
