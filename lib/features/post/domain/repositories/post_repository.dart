import 'package:dartz/dartz.dart';

import 'package:clean_arch_demo/core/error/failures.dart';
import 'package:clean_arch_demo/features/post/domain/entities/post.dart';

/// HỢP ĐỒNG (abstraction) do Domain định nghĩa.
/// Tầng Data sẽ implement; Domain & Presentation chỉ biết interface này
/// => Dependency Inversion Principle.
abstract class PostRepository {
  Future<Either<Failure, List<Post>>> getPosts();
}
