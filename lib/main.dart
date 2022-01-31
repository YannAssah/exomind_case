import 'package:exomind_case/views/homepage.dart';
import 'package:exomind_case/views/test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart' as dot_env;

Future main() async {
  await dot_env.load(fileName: ".env");
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(),
      home: const MyHomePage(title: 'Weather App'),
      //home: const TestLoad(),
    );
  }
}
