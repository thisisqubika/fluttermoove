import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorage {
  final _storage = const FlutterSecureStorage();

  Future<void> write(String key, dynamic value) async {
    await _storage.write(key: key, value: value);
  }

  Future<String?> read(String key) async {
    String? value = await _storage.read(key: key);
    return value;
  }

  void delete(String key) {
    _storage.delete(key: key);
  }
}
