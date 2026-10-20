import 'package:clean_arch_demo/core/error/exceptions.dart';
import 'package:clean_arch_demo/core/error/failures.dart';
import 'package:clean_arch_demo/features/post/data/datasources/post_remote_data_source.dart';
import 'package:clean_arch_demo/features/post/data/models/post_model.dart';
import 'package:clean_arch_demo/features/post/data/repositories/post_repository_impl.dart';
import 'package:clean_arch_demo/features/post/domain/entities/post.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockRemoteDataSource extends Mock implements PostRemoteDataSource {}

void main() {
  late MockRemoteDataSource remote;
  late PostRepositoryImpl repository;

  setUp(() {
    remote = MockRemoteDataSource();
    repository = PostRepositoryImpl(remote);
  });

  test('map PostModel -> Post khi DataSource thành công', () async {
    when(() => remote.fetchPosts()).thenAnswer(
      (_) async => const [PostModel(id: 1, userId: 2, title: 't', body: 'b')],
    );

    final result = await repository.getPosts();

    expect(
      result.getOrElse(() => []),
      const [Post(id: 1, userId: 2, title: 't', body: 'b')],
    );
  });

  test('ServerException -> ServerFailure', () async {
    when(() => remote.fetchPosts())
        .thenThrow(const ServerException('boom', statusCode: 500));

    final result = await repository.getPosts();

    expect(result.fold((f) => f, (_) => null), const ServerFailure('boom'));
  });

  test('NetworkException -> NetworkFailure', () async {
    when(() => remote.fetchPosts()).thenThrow(const NetworkException());

    final result = await repository.getPosts();

    expect(result.fold((f) => f, (_) => null), isA<NetworkFailure>());
  });
}
