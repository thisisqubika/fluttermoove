import 'package:flutter_template/data/secure_storage.dart';
import 'package:flutter_template/constants/storage.dart';
import 'package:flutter_template/data/models/user.dart';
import 'package:flutter_template/data/network/http_client.dart';

class UserRepository {
  final HttpClient _httpClient = HttpClient();
  final SecureStorage _secureStorage = SecureStorage();

  Future<String> doLogin(String email, String password) async {
    String jwtResponse = '1234';
    await _secureStorage.write(sessionToken, jwtResponse);
    return jwtResponse;
  }

  Future<User> getUser() async {
    // final response = await _httpClient.get(userRoute);
    // User user = User.fromJson(jsonDecode(response));
    User user = User("John", "Doe", "john@doe.com", 1);
    return user;
  }

  Future<void> doLogout() async {
    _secureStorage.delete(sessionToken);
  }
}
