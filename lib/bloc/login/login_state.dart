part of 'login_cubit.dart';

abstract class LoginState extends Equatable {}

class LoginLoading extends LoginState {
  @override
  List<Object?> get props => [];
}

class LoginInitial extends LoginState {
  @override
  List<Object?> get props => [];
}

class LoginFailure extends LoginState {
  @override
  List<Object?> get props => [];
}

class LoginSuccess extends LoginState {
  final User user;

  LoginSuccess(this.user);

  @override
  List<Object?> get props => [user.id];
}
