class NetworkException implements Exception {
  final _message;
  final _prefix;

  NetworkException([this._message, this._prefix]);

  String toString() {
    return "$_prefix$_message";
  }
}

class FetchDataException extends NetworkException {
  FetchDataException([String? message])
      : super(message, "Error During Communication: ");
}

class BadRequestException extends NetworkException {
  BadRequestException([message]) : super(message, "Invalid Request: ");
}

class UnauthorizedException extends NetworkException {
  UnauthorizedException([message]) : super(message, "Unauthorized: ");
}

class InvalidInputException extends NetworkException {
  InvalidInputException([String? message]) : super(message, "Invalid Input: ");
}
