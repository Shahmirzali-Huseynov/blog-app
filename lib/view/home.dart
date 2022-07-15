import 'package:blog_app/core/utils/providers/auth_control.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MyApp extends ConsumerWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final homePage = ref.watch(authControlProvider);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Blog app',
      home: homePage,
    );
  }
}
