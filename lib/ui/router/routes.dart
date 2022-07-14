import 'package:flutter/material.dart';
import 'package:flutter_template/ui/router/app_routes.dart';
import 'package:flutter_template/ui/router/auth_route_resolver.dart';
import 'package:flutter_template/ui/screens/home/home.dart';
import 'package:flutter_template/ui/screens/login/login.dart';

class AppRouter {
  Route onGenerateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case login:
        return MaterialPageRoute(
          builder: (_) => const LoginWidget(),
        );
      case home:
        return MaterialPageRoute(
          builder: (_) => const HomeWidget(),
        );
      default:
        return MaterialPageRoute(
          builder: (_) => const AuthRouteResolverWidget(),
        );
    }
  }
}
