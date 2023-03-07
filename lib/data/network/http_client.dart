import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:flutter_template/services/secure_storage.dart';
import 'package:flutter_template/constants/env_config.dart';
import 'package:flutter_template/constants/storage.dart';
import 'package:flutter_template/data/network/network_exceptions.dart';

class HttpClient {
  final String _baseUrl = API_URL!;

  final SecureStorage _secureStorage = SecureStorage();

  Future<dynamic> get(String url) async {
    var responseJson;
    String token = await _secureStorage.read(apiKey);
    try {
      final response = await http.get(Uri.parse(_baseUrl + url), headers: {
        HttpHeaders.authorizationHeader: "Bearer $token",
      });
      responseJson = _returnResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet connection');
    }
    return responseJson;
  }

  Future<dynamic> post(String url, Map? body) async {
    var responseJson;
    String token = await _secureStorage.read(apiKey);

    try {
      final response = await http.post(Uri.parse(_baseUrl + url),
          headers: {
            HttpHeaders.contentTypeHeader: "application/json",
            HttpHeaders.authorizationHeader: token
          },
          body: json.encode(body));
      responseJson = _returnResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet connection');
    }
    return responseJson;
  }

  dynamic _returnResponse(http.Response response) {
    switch (response.statusCode) {
      case 200:
        return response.body;
      case 400:
        throw BadRequestException(response.body.toString());
      case 401:
      case 403:
        throw UnauthorizedException(response.body.toString());
      case 500:
      default:
        throw FetchDataException(
            'Error occured while Communication with Server with StatusCode : ${response.statusCode}');
    }
  }
}
