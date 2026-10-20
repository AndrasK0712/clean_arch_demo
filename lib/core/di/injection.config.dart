// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes

import 'package:clean_arch_demo/core/di/register_module.dart' as _i389;
import 'package:clean_arch_demo/features/post/data/datasources/post_remote_data_source.dart'
    as _i243;
import 'package:clean_arch_demo/features/post/data/repositories/post_repository_impl.dart'
    as _i505;
import 'package:clean_arch_demo/features/post/domain/repositories/post_repository.dart'
    as _i221;
import 'package:clean_arch_demo/features/post/domain/usecases/get_posts.dart'
    as _i79;
import 'package:clean_arch_demo/features/post/presentation/bloc/post_bloc.dart'
    as _i917;
import 'package:dio/dio.dart' as _i361;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;

extension GetItInjectableX on _i174.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    final registerModule = _$RegisterModule();
    gh.lazySingleton<_i361.Dio>(() => registerModule.dio);
    gh.lazySingleton<_i243.PostRemoteDataSource>(
        () => _i243.PostRemoteDataSourceImpl(gh<_i361.Dio>()));
    gh.lazySingleton<_i221.PostRepository>(
        () => _i505.PostRepositoryImpl(gh<_i243.PostRemoteDataSource>()));
    gh.lazySingleton<_i79.GetPosts>(
        () => _i79.GetPosts(gh<_i221.PostRepository>()));
    gh.factory<_i917.PostBloc>(() => _i917.PostBloc(gh<_i79.GetPosts>()));
    return this;
  }
}

class _$RegisterModule extends _i389.RegisterModule {}
