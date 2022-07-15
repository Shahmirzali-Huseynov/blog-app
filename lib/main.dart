import 'package:blog_app/core/cache/locale_manager.dart';
import 'package:blog_app/view/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");
  await LocaleManager.prefrencesInit();

  return runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}
