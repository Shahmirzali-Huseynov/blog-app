import 'package:blog_app/core/extensions/context_extensions.dart';
import 'package:blog_app/core/service/state/view_state.dart';
import 'package:blog_app/core/utils/providers/update_post_ui_control.dart';
import 'package:blog_app/core/utils/ui/textfield_decoration.dart';
import 'package:blog_app/core/widgets/buttons/button_widget.dart';
import 'package:blog_app/model/response_model/posts/post_model.dart';
import 'package:blog_app/view_model/comment/add_comment_view_model.dart';
import 'package:blog_app/view_model/posts/all_posts_view_model.dart';
import 'package:blog_app/view_model/posts/post_detail_view_model.dart';
import 'package:blog_app/view_model/posts/update_post_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PostDetailPage extends ConsumerWidget {
  const PostDetailPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final postDetailViewModel = ref.watch(postDetailViewModelProvider);
    final updatePostUiControl = ref.watch(updatePostUiControlProvider);
    final updatePostViewModel = ref.watch(updatePostViewModelProvider);
    final addCommentViewModel = ref.watch(addCommentViewModelProvider);
    return ScaffoldMessenger(
      key: updatePostViewModel.scaffoldMessengerKey,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Post Detail Page'),
          actions: [
            IconButton(
              onPressed: () async {
                ref.refresh(updatePostUiControlProvider.notifier).update((state) => state = !updatePostUiControl);
              },
              icon: const Icon(Icons.edit),
            ),
          ],
        ),
        body: postDetailViewModel.viewState.state == ResponseState.COMPLETE
            ? SingleChildScrollView(
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
                      controller: postDetailViewModel.titleController,
                      autofocus: false,
                      keyboardType: TextInputType.multiline,
                      minLines: 1,
                      enabled: updatePostUiControl == false ? false : true,
                      maxLines: null,
                      decoration: textFormFieldDecoration(
                        context: context,
                        enabledBorderSide: updatePostUiControl == false
                            ? null
                            : const BorderSide(
                                color: Color.fromARGB(193, 0, 22, 111),
                                width: 1.5,
                              ),
                        focusedBorderSide: updatePostUiControl == false
                            ? null
                            : const BorderSide(
                                color: Color.fromARGB(193, 0, 22, 111),
                                width: 1.5,
                              ),
                        contentPadding: context.paddingSymmetric(15, updatePostUiControl == false ? 0 : 15),
                        fillColor: updatePostUiControl == false ? Colors.transparent : const Color(0xC1D6EBFF),
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
                      controller: postDetailViewModel.bodyController,
                      autofocus: false,
                      keyboardType: TextInputType.multiline,
                      minLines: 1,
                      enabled: updatePostUiControl == false ? false : true,
                      maxLines: null,
                      decoration: textFormFieldDecoration(
                        context: context,
                        enabledBorderSide: updatePostUiControl == false
                            ? null
                            : const BorderSide(
                                color: Color.fromARGB(193, 0, 22, 111),
                                width: 1.5,
                              ),
                        focusedBorderSide: updatePostUiControl == false
                            ? null
                            : const BorderSide(
                                color: Color.fromARGB(193, 0, 22, 111),
                                width: 1.5,
                              ),
                        contentPadding: context.paddingSymmetric(15, updatePostUiControl == false ? 0 : 15),
                        fillColor: updatePostUiControl == false ? Colors.transparent : const Color(0xC1D6EBFF),
                      ),
                    ),
                    if (updatePostUiControl) ...[
                      const SizedBox(height: 100),
                      Center(
                        child: ButtonWidget(
                          height: 45,
                          padding: context.paddingSymmetric(0, 20),
                          onClicked: () async {
                            updatePostViewModel
                                .fetchUpdatePostService(
                                    PostModel(
                                      title: postDetailViewModel.titleController.text,
                                      body: postDetailViewModel.bodyController.text,
                                    ),
                                    postDetailViewModel.viewState.data!.id!)
                                .then((value) {
                              ref.read(allPostsViewModelProvider).fetchAllPostsService();
                              ref
                                  .refresh(updatePostUiControlProvider.notifier)
                                  .update((state) => state = !updatePostUiControl);
                            });
                          },
                          borderRadius: const BorderRadius.all(
                            Radius.circular(8),
                          ),
                          buttonColor: Colors.blue,
                          child: Text(
                            "Update Post",
                            style: context.textTheme.headline5!.copyWith(
                              fontWeight: FontWeight.normal,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                    const SizedBox(height: 20),
                    Text(
                      "Comments",
                      style: Theme.of(context).textTheme.subtitle1?.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                    ),
                    const SizedBox(height: 10),
                    ListView.separated(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      padding: context.paddingSymmetric(20, 10),
                      itemCount: postDetailViewModel.viewState.data!.comments!.length,
                      itemBuilder: (context, index) {
                        return Text(
                          "${postDetailViewModel.viewState.data!.comments![index].body}",
                          style: Theme.of(context).textTheme.subtitle1?.copyWith(
                                fontWeight: FontWeight.w600,
                              ),
                        );
                      },
                      separatorBuilder: (context, index) {
                        return const SizedBox(
                          height: 10,
                        );
                      },
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            style: Theme.of(context).textTheme.subtitle1?.copyWith(
                                  fontWeight: FontWeight.w600,
                                ),
                            controller: addCommentViewModel.bodyController,
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
                        ),
                        IconButton(
                          onPressed: () {
                            addCommentViewModel
                                .fetchAddCommentsService(postDetailViewModel.viewState.data!.id!, context)
                                .then(
                                  (value) =>
                                      postDetailViewModel.fetchPostService(postDetailViewModel.viewState.data!.id!),
                                );
                          },
                          icon: const Icon(Icons.send),
                        ),
                      ],
                    ),
                  ],
                ),
              )
            : const Center(
                child: CircularProgressIndicator(),
              ),
      ),
    );
  }
}
