import 'package:chatbot/home.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'AI Chat-bot ',
      home: const HomePage(),
      theme: ThemeData(primaryColor: Colors.white38),
    );
  }
}

//________________________________________________________________________________
