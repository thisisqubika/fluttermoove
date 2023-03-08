import 'package:flutter/material.dart';
import 'package:flutter_template/services/secure_storage.dart';
import 'package:flutter_template/constants/storage.dart';
import 'package:flutter_template/ui/screens/home/home_navigator.dart';
import 'package:flutter_template/ui/screens/login/login.dart';

class AuthRouteResolverWidget extends StatefulWidget {
  const AuthRouteResolverWidget({Key? key}) : super(key: key);

  @override
  State<AuthRouteResolverWidget> createState() =>
      _AuthRouteResolverWidgetState();
}

class _AuthRouteResolverWidgetState extends State<AuthRouteResolverWidget> {
  final SecureStorage _secureStorage = SecureStorage();
  bool userLoggedIn = false;

  @override
  void initState() {
    super.initState();
    loadUser();
  }

  // Handler function that parses the jwt token and redirects user
  // to one screen or another based on the login status.
  void loadUser() async {
    String? token = await _secureStorage.read(sessionToken);
    try {
      if (token != null) {
        setState(() => userLoggedIn = true);
      }
    } catch (_) {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return userLoggedIn ? const HomeNavigatorWidget() : const LoginWidget();
  }
}
