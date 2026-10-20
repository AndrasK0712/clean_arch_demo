import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import 'package:clean_arch_demo/core/error/failures.dart';
import 'package:clean_arch_demo/features/post/domain/entities/post.dart';
import 'package:clean_arch_demo/features/post/domain/repositories/post_repository.dart';

/// UseCase (Interactor): một hành động nghiệp vụ duy nhất.
@lazySingleton
class GetPosts {
  const GetPosts(this._repository);

  final PostRepository _repository;

  Future<Either<Failure, List<Post>>> call() => _repository.getPosts();
}
