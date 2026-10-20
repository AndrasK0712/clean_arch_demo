import 'package:clean_arch_demo/core/error/failures.dart';
import 'package:clean_arch_demo/features/post/domain/entities/post.dart';
import 'package:clean_arch_demo/features/post/domain/repositories/post_repository.dart';
import 'package:clean_arch_demo/features/post/domain/usecases/get_posts.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

/// Mock dựng trên ABSTRACT INTERFACE của Domain.
/// File test này không import bất cứ thứ gì từ tầng Data (Dio, DataSource...).
class MockPostRepository extends Mock implements PostRepository {}

void main() {
  late MockPostRepository repository;
  late GetPosts usecase;

  const tPosts = [
    Post(id: 1, userId: 1, title: 'Tiêu đề 1', body: 'Nội dung 1'),
    Post(id: 2, userId: 1, title: 'Tiêu đề 2', body: 'Nội dung 2'),
  ];

  setUp(() {
    repository = MockPostRepository();
    usecase = GetPosts(repository);
  });

  group('GetPosts', () {
    test('trả về danh sách Post khi repository thành công', () async {
      when(() => repository.getPosts())
          .thenAnswer((_) async => const Right<Failure, List<Post>>(tPosts));

      final result = await usecase();

      expect(result, const Right<Failure, List<Post>>(tPosts));
      verify(() => repository.getPosts()).called(1);
      verifyNoMoreInteractions(repository);
    });

    test('trả về Failure khi repository báo lỗi', () async {
      when(() => repository.getPosts()).thenAnswer(
        (_) async => const Left<Failure, List<Post>>(ServerFailure('500')),
      );

      final result = await usecase();

      expect(result, const Left<Failure, List<Post>>(ServerFailure('500')));
      verify(() => repository.getPosts()).called(1);
      verifyNoMoreInteractions(repository);
    });
  });
}
