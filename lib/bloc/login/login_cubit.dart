import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_template/data/models/user.dart';
import 'package:flutter_template/data/repositories/user_repository.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  final UserRepository userRepository;

  LoginCubit({required UserRepository repository})
      : userRepository = repository,
        super(LoginInitial());

  Future<void> login(String email, String password) async {
    try {
      emit(LoginLoading());
      await userRepository.doLogin(email, password);
      User user = await userRepository.getUser();
      Future.delayed(const Duration(seconds: 1), () {
        emit(LoginSuccess(user));
      });
    } catch (exception) {
      emit(LoginFailure());
    }
  }

  void logout() async {
    await userRepository.doLogout();
    emit(LoginInitial());
  }
}
