import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import 'package:clean_arch_demo/core/error/exceptions.dart';
import 'package:clean_arch_demo/core/error/failures.dart';
import 'package:clean_arch_demo/features/post/data/datasources/post_remote_data_source.dart';
import 'package:clean_arch_demo/features/post/domain/entities/post.dart';
import 'package:clean_arch_demo/features/post/domain/repositories/post_repository.dart';

/// Implement hợp đồng của Domain. `as: PostRepository` giúp injectable
/// đăng ký: khi ai xin PostRepository -> trả về PostRepositoryImpl.
@LazySingleton(as: PostRepository)
class PostRepositoryImpl implements PostRepository {
  const PostRepositoryImpl(this._remote);

  final PostRemoteDataSource _remote;

  @override
  Future<Either<Failure, List<Post>>> getPosts() async {
    try {
      final models = await _remote.fetchPosts();
      return Right(models.map((m) => m.toEntity()).toList());
    } on NetworkException catch (e) {
      return Left(NetworkFailure(e.message));
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } catch (_) {
      return const Left(UnexpectedFailure());
    }
  }
}
