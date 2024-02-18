import 'package:flutter/material.dart';

class AppBarBackButton extends StatelessWidget {
  final Color buttonColor;

  const AppBarBackButton({
    super.key,
    this.buttonColor = Colors.black,
  });
  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back_ios_new_rounded),
      color: buttonColor,
      onPressed: () {
        Navigator.pop(context);
      },
    );
  }
}

class AppBarTitle extends StatelessWidget {
  const AppBarTitle({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: const TextStyle(
        color: Colors.black,
        fontFamily: 'Acme',
        fontSize: 28,
        letterSpacing: 1.5,
      ),
    );
  }
}
