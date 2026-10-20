import 'package:equatable/equatable.dart';

/// Lỗi ở mức nghiệp vụ, được Domain/Presentation hiểu (không lộ chi tiết Dio, HTTP...).
abstract class Failure extends Equatable {
  const Failure(this.message);
  final String message;

  @override
  List<Object?> get props => [message];
}

class ServerFailure extends Failure {
  const ServerFailure(super.message);
}

class NetworkFailure extends Failure {
  const NetworkFailure([super.message = 'Không có kết nối mạng']);
}

class UnexpectedFailure extends Failure {
  const UnexpectedFailure([super.message = 'Đã xảy ra lỗi không xác định']);
}
