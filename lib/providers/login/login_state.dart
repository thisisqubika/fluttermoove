import 'package:flutter_template/data/models/user.dart';

class LoginState {
  final User? user;
  final Exception? error;
  final bool isUserAuthenticated;
  final bool isLoading;

  LoginState({
    this.user,
    this.error,
    required this.isUserAuthenticated,
    required this.isLoading,
  });

  LoginState.loggedIn(User this.user)
      : isUserAuthenticated = true,
        isLoading = false,
        error = null;

  LoginState.loggedOut()
      : user = null,
        error = null,
        isLoading = false,
        isUserAuthenticated = false;

  LoginState.loading()
      : isLoading = true,
        user = null,
        error = null,
        isUserAuthenticated = false;

  LoginState.error(Exception this.error)
      : user = null,
        isLoading = false,
        isUserAuthenticated = false;
}
