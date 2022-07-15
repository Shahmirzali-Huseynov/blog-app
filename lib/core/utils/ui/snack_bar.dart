import 'package:blog_app/core/extensions/context_extensions.dart';
import 'package:flutter/material.dart';

SnackBar snackBar(String title, BuildContext context) {
  return SnackBar(
    padding: const EdgeInsets.all(10),
    backgroundColor: Colors.black,
    content: Text(
      title,
      style: context.textTheme.headline6!.copyWith(
        fontWeight: FontWeight.w500,
        color: Colors.white,
      ),
    ),
  );
}
