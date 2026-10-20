import 'package:clean_arch_demo/core/error/failures.dart';
import 'package:clean_arch_demo/features/post/domain/entities/post.dart';
import 'package:clean_arch_demo/features/post/domain/repositories/post_repository.dart';
import 'package:clean_arch_demo/features/post/domain/usecases/get_posts.dart';
import 'package:clean_arch_demo/features/post/presentation/bloc/post_bloc.dart';
import 'package:clean_arch_demo/features/post/presentation/pages/post_list_page.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';

/// Repository giả (chỉ implement interface của Domain) -> UI chạy được mà
/// KHÔNG cần Dio/DataSource. Đây là bằng chứng Presentation không phụ thuộc Data.
class FakePostRepository implements PostRepository {
  FakePostRepository(this.result);
  final Either<Failure, List<Post>> result;

  @override
  Future<Either<Failure, List<Post>>> getPosts() async => result;
}

Widget _wrap(PostRepository repo) => MaterialApp(
      home: BlocProvider(
        create: (_) => PostBloc(GetPosts(repo))..add(const PostsRequested()),
        child: const PostListPage(),
      ),
    );

void main() {
  testWidgets('hiển thị danh sách khi thành công', (tester) async {
    final repo = FakePostRepository(
      const Right([Post(id: 1, userId: 1, title: 'Xin chào', body: 'Nội dung')]),
    );

    await tester.pumpWidget(_wrap(repo));
    await tester.pumpAndSettle();

    expect(find.text('Xin chào'), findsOneWidget);
  });

  testWidgets('hiển thị lỗi và nút Thử lại khi thất bại', (tester) async {
    final repo = FakePostRepository(const Left(ServerFailure('Lỗi máy chủ')));

    await tester.pumpWidget(_wrap(repo));
    await tester.pumpAndSettle();

    expect(find.text('Lỗi máy chủ'), findsOneWidget);
    expect(find.text('Thử lại'), findsOneWidget);
  });
}
