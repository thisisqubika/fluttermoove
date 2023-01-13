import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_template/bloc/login/login_cubit.dart';
import 'package:flutter_template/data/models/user.dart';
import 'package:mocktail/mocktail.dart';

class MockLoginCubit extends MockCubit<LoginState> implements LoginCubit {
  @override
  Future<void> login(String email, String password) async {
    User user = User("Mockity", "Mock", "mock@mockity.com", 1);
    emit(LoginSuccess(user));
  }
}

class MockLoginState extends Fake implements LoginState {}
