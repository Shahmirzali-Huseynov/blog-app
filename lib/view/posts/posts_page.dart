import 'package:blog_app/core/cache/locale_manager.dart';
import 'package:blog_app/core/extensions/context_extensions.dart';
import 'package:blog_app/core/service/state/view_state.dart';
import 'package:blog_app/core/utils/enums/preferences_keys_enum.dart';
import 'package:blog_app/core/widgets/cards/post_card.dart';
import 'package:blog_app/service/blog_posts_service/blog_posts_services.dart';
import 'package:blog_app/view/auth/sign_in_page.dart';
import 'package:blog_app/view/posts/post_create_page.dart';
import 'package:blog_app/view/posts/post_detail_page.dart';
import 'package:blog_app/view_model/posts/all_posts_view_model.dart';
import 'package:blog_app/view_model/posts/post_detail_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PostsPage extends ConsumerStatefulWidget {
  const PostsPage({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _PostsPageState();
}

class _PostsPageState extends ConsumerState<PostsPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(allPostsViewModelProvider).fetchAllPostsService();
    });
  }

  @override
  Widget build(BuildContext context) {
    final allPostsViewModel = ref.watch(allPostsViewModelProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Posts Page'),
        actions: [
          IconButton(
            onPressed: () async {
              await LocaleManager.instance.clearValue(PreferencesKeys.TOKEN).then(
                    (value) => Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const SignInPage(),
                      ),
                    ),
                  );
            },
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
      body: allPostsViewModel.viewState.state == ResponseState.COMPLETE
          ? ListView.separated(
              padding: context.paddingSymmetric(20, 10),
              itemCount: allPostsViewModel.viewState.data!.length,
              itemBuilder: (context, index) {
                return PostCard(
                  title: "${allPostsViewModel.viewState.data![index].title} $index",
                  cardOnTap: () async {
                    ref
                        .read(postDetailViewModelProvider)
                        .fetchPostService(allPostsViewModel.viewState.data![index].id!);
                    Navigator.push(context, MaterialPageRoute(builder: (context) => const PostDetailPage()));
                  },
                  deleteOnTap: (context) {
                    PostsServices().deletePost(allPostsViewModel.viewState.data![index].id!);
                    setState((() {
                      allPostsViewModel.viewState.data?.removeAt(index);
                    }));
                  },
                );
              },
              separatorBuilder: (context, index) {
                return const SizedBox(
                  height: 10,
                );
              },
            )
          : const Center(
              child: CircularProgressIndicator(),
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => const CreatePostPage()));
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
