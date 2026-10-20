part of 'post_bloc.dart';

enum PostStatus { initial, loading, success, failure }

class PostState extends Equatable {
  const PostState({
    this.status = PostStatus.initial,
    this.posts = const [],
    this.message = '',
  });

  final PostStatus status;
  final List<Post> posts;
  final String message;

  PostState copyWith({
    PostStatus? status,
    List<Post>? posts,
    String? message,
  }) =>
      PostState(
        status: status ?? this.status,
        posts: posts ?? this.posts,
        message: message ?? this.message,
      );

  @override
  List<Object?> get props => [status, posts, message];
}
