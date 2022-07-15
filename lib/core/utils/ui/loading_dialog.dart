import 'package:flutter/material.dart';

typedef CloseDialog = void Function();

CloseDialog showLoadingScreen({
  required BuildContext context,
}) {
  final dialog = WillPopScope(
    child: const AlertDialog(
      backgroundColor: Colors.transparent,
      elevation: 0,
      content: Center(child: CircularProgressIndicator()),
    ),
    onWillPop: () {
      return Future<bool>(() => false);
    },
  );

  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (_) => dialog,
  );

  return () => Navigator.of(context).pop();
}
