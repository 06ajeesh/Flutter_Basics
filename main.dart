import 'package:flutter/material.dart';
import 'package:first_app/pages/home.dart';
import 'package:first_app/pages/_loading.dart';
void main(){
  //Future<void>main()async{
  // WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Calculator",
      debugShowCheckedModeBanner: false,
       // Use the global theme from theme.dart
      initialRoute: '/',
      routes: {
        '/': (context) => const LoadScreen(),
        '/home': (context) => const Home(),
      },
    );
  }
}
