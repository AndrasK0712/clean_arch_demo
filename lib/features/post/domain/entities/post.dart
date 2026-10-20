import 'package:equatable/equatable.dart';

/// Entity thuần nghiệp vụ: không biết gì về JSON, Dio hay Flutter.
class Post extends Equatable {
  const Post({
    required this.id,
    required this.userId,
    required this.title,
    required this.body,
  });

  final int id;
  final int userId;
  final String title;
  final String body;

  @override
  List<Object?> get props => [id, userId, title, body];
}
