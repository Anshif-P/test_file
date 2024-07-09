class AppException implements Exception {
  String message;
  AppException(this.message);
}

class BadRequestException extends AppException {
  BadRequestException() : super('Somthing went wrong');
}

class NetWorkNotFoundException extends AppException {
  NetWorkNotFoundException() : super('Network Not Found');
}

class RequestTimeOutException extends AppException {
  RequestTimeOutException() : super('Request Time Out Exception');
}
