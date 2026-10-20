import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

import 'package:clean_arch_demo/core/error/exceptions.dart';
import 'package:clean_arch_demo/features/post/data/models/post_model.dart';

abstract class PostRemoteDataSource {
  Future<List<PostModel>> fetchPosts();
}

@LazySingleton(as: PostRemoteDataSource)
class PostRemoteDataSourceImpl implements PostRemoteDataSource {
  const PostRemoteDataSourceImpl(this._dio);

  final Dio _dio;

  @override
  Future<List<PostModel>> fetchPosts() async {
    try {
      final response = await _dio.get<List<dynamic>>('/posts');
      final data = response.data ?? const <dynamic>[];
      return data
          .map((e) => PostModel.fromJson(e as Map<String, dynamic>))
          .toList();
    } on DioException catch (e) {
      switch (e.type) {
        case DioExceptionType.connectionError:
        case DioExceptionType.connectionTimeout:
        case DioExceptionType.sendTimeout:
        case DioExceptionType.receiveTimeout:
          throw const NetworkException();
        default:
          throw ServerException(
            e.message ?? 'Lỗi máy chủ',
            statusCode: e.response?.statusCode,
          );
      }
    }
  }
}
