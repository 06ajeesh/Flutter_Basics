import 'package:basic_calculator/pages/fitings.dart';
import 'package:flutter/material.dart';

import 'calculator_body.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Calculator",
          style: tStyle.copyWith(
            fontSize: 22,
          ),
        ),
        centerTitle: true,
      ),
      body: CalculatorBody(),
    );
  }
}
