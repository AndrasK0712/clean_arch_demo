import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import 'package:clean_arch_demo/features/post/domain/entities/post.dart';
import 'package:clean_arch_demo/features/post/domain/usecases/get_posts.dart';

part 'post_event.dart';
part 'post_state.dart';

/// Bloc chỉ phụ thuộc UseCase (Domain). Không import Dio/DataSource/Repository impl.
@injectable
class PostBloc extends Bloc<PostEvent, PostState> {
  PostBloc(this._getPosts) : super(const PostState()) {
    on<PostsRequested>(_onRequested);
  }

  final GetPosts _getPosts;

  Future<void> _onRequested(
    PostsRequested event,
    Emitter<PostState> emit,
  ) async {
    emit(state.copyWith(status: PostStatus.loading));
    final result = await _getPosts();
    result.fold(
      (failure) => emit(
        state.copyWith(status: PostStatus.failure, message: failure.message),
      ),
      (posts) => emit(
        state.copyWith(status: PostStatus.success, posts: posts),
      ),
    );
  }
}
