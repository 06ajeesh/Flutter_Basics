import 'package:flutter/material.dart';
import 'package:weather_app_task/home_page.dart';
import 'package:weather_app_task/welcome_page.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const WelcomePage(),
      routes: {
        '/home': (context) => HomePage(),
      },
    );
  }
}
