import 'package:blog_app/core/extensions/context_extensions.dart';
import 'package:blog_app/core/utils/ui/textfield_decoration.dart';
import 'package:blog_app/core/widgets/buttons/button_widget.dart';
import 'package:blog_app/view_model/posts/all_posts_view_model.dart';
import 'package:blog_app/view_model/posts/create_post_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CreatePostPage extends ConsumerWidget {
  const CreatePostPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final createPostViewModel = ref.watch(createPostViewModelProvider);
    return ScaffoldMessenger(
      key: createPostViewModel.scaffoldMessengerKey,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Post Create Page'),
        ),
        body: SingleChildScrollView(
          padding: context.paddingSymmetric(20, 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Title",
                style: Theme.of(context).textTheme.subtitle1?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
              ),
              const SizedBox(height: 10),
              TextFormField(
                style: Theme.of(context).textTheme.subtitle1?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                controller: createPostViewModel.titleController,
                autofocus: false,
                keyboardType: TextInputType.multiline,
                minLines: 1,
                maxLines: null,
                decoration: textFormFieldDecoration(
                  context: context,
                  enabledBorderSide: const BorderSide(
                    color: Color.fromARGB(193, 0, 22, 111),
                    width: 1.5,
                  ),
                  focusedBorderSide: const BorderSide(
                    color: Color.fromARGB(193, 0, 22, 111),
                    width: 1.5,
                  ),
                  contentPadding: context.paddingSymmetric(15, 15),
                  fillColor: const Color(0xC1D6EBFF),
                ),
              ),
              const SizedBox(height: 20),
              Text(
                "Body",
                style: Theme.of(context).textTheme.subtitle1?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
              ),
              const SizedBox(height: 10),
              TextFormField(
                style: Theme.of(context).textTheme.subtitle1?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                controller: createPostViewModel.bodyController,
                autofocus: false,
                keyboardType: TextInputType.multiline,
                minLines: 1,
                maxLines: null,
                decoration: textFormFieldDecoration(
                  context: context,
                  enabledBorderSide: const BorderSide(
                    color: Color.fromARGB(193, 0, 22, 111),
                    width: 1.5,
                  ),
                  focusedBorderSide: const BorderSide(
                    color: Color.fromARGB(193, 0, 22, 111),
                    width: 1.5,
                  ),
                  contentPadding: context.paddingSymmetric(15, 15),
                  fillColor: const Color(0xC1D6EBFF),
                ),
              ),
              const SizedBox(height: 200),
              Center(
                child: ButtonWidget(
                  height: 45,
                  padding: context.paddingSymmetric(0, 20),
                  onClicked: () async {
                    createPostViewModel.fetchCreatePostService().then((value) {
                      ref.read(allPostsViewModelProvider).fetchAllPostsService();
                    });
                  },
                  borderRadius: const BorderRadius.all(
                    Radius.circular(8),
                  ),
                  buttonColor: Colors.blue,
                  child: Text(
                    "Create Post",
                    style: context.textTheme.headline5!.copyWith(
                      fontWeight: FontWeight.normal,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
