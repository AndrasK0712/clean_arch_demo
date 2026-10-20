import 'package:equatable/equatable.dart';

import 'package:clean_arch_demo/features/post/domain/entities/post.dart';

/// Model biết về JSON; Entity thì không. Chuyển đổi bằng [toEntity].
class PostModel extends Equatable {
  const PostModel({
    required this.id,
    required this.userId,
    required this.title,
    required this.body,
  });

  factory PostModel.fromJson(Map<String, dynamic> json) => PostModel(
        id: json['id'] as int,
        userId: json['userId'] as int,
        title: json['title'] as String,
        body: json['body'] as String,
      );

  final int id;
  final int userId;
  final String title;
  final String body;

  Post toEntity() => Post(id: id, userId: userId, title: title, body: body);

  @override
  List<Object?> get props => [id, userId, title, body];
}
