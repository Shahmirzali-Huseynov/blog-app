import 'package:blog_app/core/cache/locale_manager.dart';
import 'package:blog_app/core/utils/enums/preferences_keys_enum.dart';
import 'package:blog_app/view/auth/sign_in_page.dart';
import 'package:blog_app/view/posts/posts_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final authControlProvider = StateProvider<Widget>((ref) {
  String? token = LocaleManager.instance.getStringValue(PreferencesKeys.TOKEN);
  return token == null ? const SignInPage() : const PostsPage();
});
