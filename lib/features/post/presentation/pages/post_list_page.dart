import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:clean_arch_demo/features/post/domain/entities/post.dart';
import 'package:clean_arch_demo/features/post/presentation/bloc/post_bloc.dart';

class PostListPage extends StatelessWidget {
  const PostListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Bài viết • Clean Architecture')),
      body: BlocBuilder<PostBloc, PostState>(
        builder: (context, state) {
          return switch (state.status) {
            PostStatus.initial ||
            PostStatus.loading =>
              const Center(child: CircularProgressIndicator()),
            PostStatus.failure => _ErrorView(
                message: state.message,
                onRetry: () =>
                    context.read<PostBloc>().add(const PostsRequested()),
              ),
            PostStatus.success => _PostList(posts: state.posts),
          };
        },
      ),
    );
  }
}

class _PostList extends StatelessWidget {
  const _PostList({required this.posts});

  final List<Post> posts;

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async =>
          context.read<PostBloc>().add(const PostsRequested()),
      child: ListView.separated(
        itemCount: posts.length,
        separatorBuilder: (_, __) => const Divider(height: 1),
        itemBuilder: (context, index) {
          final post = posts[index];
          return ListTile(
            leading: CircleAvatar(child: Text('${post.id}')),
            title: Text(post.title, maxLines: 1, overflow: TextOverflow.ellipsis),
            subtitle: Text(post.body, maxLines: 2, overflow: TextOverflow.ellipsis),
          );
        },
      ),
    );
  }
}

class _ErrorView extends StatelessWidget {
  const _ErrorView({required this.message, required this.onRetry});

  final String message;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.error_outline, size: 48),
            const SizedBox(height: 12),
            Text(message, textAlign: TextAlign.center),
            const SizedBox(height: 16),
            FilledButton(onPressed: onRetry, child: const Text('Thử lại')),
          ],
        ),
      ),
    );
  }
}
