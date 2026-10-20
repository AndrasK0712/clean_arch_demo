import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';

import 'package:clean_arch_demo/core/di/injection.config.dart';

/// Service locator toàn cục (chỉ dùng ở "composition root": main/app).
final GetIt getIt = GetIt.instance;

/// Hàm `init()` được sinh bởi `build_runner` vào injection.config.dart.
@InjectableInit()
void configureDependencies() => getIt.init();
