import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'package:clean_arch_demo/app.dart';
import 'package:clean_arch_demo/core/di/injection.dart';

Future<void> main() async {
  // 1. Khởi tạo binding trước khi gọi bất kỳ plugin/async nào.
  WidgetsFlutterBinding.ensureInitialized();
  // 2. Nạp biến môi trường (.env).
  await dotenv.load(fileName: '.env');
  // 3. Đăng ký toàn bộ phụ thuộc (get_it + injectable).
  configureDependencies();
  // 4. Chạy app.
  runApp(const App());
}
