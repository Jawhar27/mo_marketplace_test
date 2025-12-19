class ApiException implements Exception {
  final int? statusCode;
  final String? message;
  final String? error;

  ApiException({this.message, this.error, this.statusCode});

  @override
  String toString() => 'ApiException ($statusCode): $message';
}
