import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_template/data/models/user.dart';
import 'package:flutter_template/data/repositories/user_repository.dart';
import 'package:flutter_template/main.dart';
import 'package:flutter_template/providers/login/login_state.dart';

final loginProvider =
    StateNotifierProvider<UserStateNotifier, LoginState>((ref) {
  UserRepository userRepository = getIt<UserRepository>();
  return UserStateNotifier(userRepository);
});

class UserStateNotifier extends StateNotifier<LoginState> {
  final UserRepository _userRepository;

  UserStateNotifier(
    this._userRepository,
  ) : super(LoginState.loggedOut());

  void login(String email, String password) async {
    try {
      state = LoginState.loading();
      await _userRepository.doLogin(email, password);
      User user = await _userRepository.getUser();
      Future.delayed(
          const Duration(seconds: 1), () => state = LoginState.loggedIn(user));
    } on Exception catch (exception) {
      state = LoginState.error(exception);
    }
  }

  void logout() async {
    await _userRepository.doLogout();
    state = LoginState.loggedOut();
  }
}
