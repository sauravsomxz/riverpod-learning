import 'package:flutter/material.dart';
import 'package:riverpod_test/config/app_env.dart';
import 'package:riverpod_test/pages/home_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await AppEnv.load();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Riverpod Test',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal),
      ),
      home: HomePage(),
    );
  }
}