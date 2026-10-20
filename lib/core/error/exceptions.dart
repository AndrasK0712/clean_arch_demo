/// Exception ném ra bởi tầng Data (DataSource).
/// Repository sẽ bắt và đổi thành Failure để trả lên Domain.
class ServerException implements Exception {
  const ServerException(this.message, {this.statusCode});
  final String message;
  final int? statusCode;

  @override
  String toString() => 'ServerException($statusCode): $message';
}

class NetworkException implements Exception {
  const NetworkException([this.message = 'Không có kết nối mạng']);
  final String message;

  @override
  String toString() => 'NetworkException: $message';
}
