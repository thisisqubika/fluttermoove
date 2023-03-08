import 'package:flutter_template/data/models/user.dart';

abstract class IUserRepository {
  Future<String> doLogin(String email, String password);
  Future<User> getUser();
  Future<void> doLogout();
}
