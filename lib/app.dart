import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:clean_arch_demo/core/di/injection.dart';
import 'package:clean_arch_demo/features/post/presentation/bloc/post_bloc.dart';
import 'package:clean_arch_demo/features/post/presentation/pages/post_list_page.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    // Composition root: nơi DUY NHẤT lấy đối tượng từ get_it rồi cấp cho cây widget.
    return MultiBlocProvider(
      providers: [
        BlocProvider<PostBloc>(
          create: (_) => getIt<PostBloc>()..add(const PostsRequested()),
        ),
      ],
      child: MaterialApp(
        title: 'Clean Architecture Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(useMaterial3: true, colorSchemeSeed: Colors.indigo),
        home: const PostListPage(),
      ),
    );
  }
}
