import 'package:flutter_template/constants/storage.dart';
import 'package:flutter_template/data/models/user.dart';
import 'package:flutter_template/data/network/http_client.dart';
import 'package:flutter_template/data/repositories/interfaces/i_user_repository.dart';
import 'package:flutter_template/main.dart';
import 'package:flutter_template/services/secure_storage.dart';

class UserRepository implements IUserRepository {
  final HttpClient _httpClient = getIt<HttpClient>();
  final SecureStorage _secureStorage = getIt<SecureStorage>();

  @override
  Future<String> doLogin(String email, String password) async {
    String jwtResponse = '1234';
    await _secureStorage.write(sessionToken, jwtResponse);
    return jwtResponse;
  }

  @override
  Future<User> getUser() async {
    // final response = await _httpClient.get(userRoute);
    // User user = User.fromJson(jsonDecode(response));
    User user = User("John", "Doe", "john@doe.com", 1);
    return user;
  }

  @override
  Future<void> doLogout() async {
    _secureStorage.delete(sessionToken);
  }
}
