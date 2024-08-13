import 'package:basic_calculator/pages/fitings.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:basic_calculator/models/calculator_model.dart';

class CalculatorBody extends StatelessWidget {
  const CalculatorBody({super.key});

  Widget _buildButton(String buttonText, Color color, CalculatorModel model) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(6.0),
        child: OutlinedButton(
          style: OutlinedButton.styleFrom(
            shape: BeveledRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            padding: const EdgeInsets.all(24.0),
            backgroundColor: color,
          ),
          onPressed: () => model.buttonPressed(buttonText),
          child: Text(
            buttonText,
            style: tStyle.copyWith(
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final model = Provider.of<CalculatorModel>(context);
    return Column(
      children: [
        Expanded(
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 14),
            alignment: Alignment.bottomRight,
            child: Text(
              model.output,
              style: tStyle.copyWith(
                fontSize: 40,
              ),
            ),
          ),
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildButton("C", Colors.red, model),
                _buildButton("0", Colors.blue, model),
                _buildButton(".", Colors.orange, model),
                _buildButton("=", Colors.grey, model),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildButton("7", Colors.blue, model),
                _buildButton("8", Colors.blue, model),
                _buildButton("9", Colors.blue, model),
                _buildButton("*", Colors.orange, model),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildButton("4", Colors.blue, model),
                _buildButton("5", Colors.blue, model),
                _buildButton("6", Colors.blue, model),
                _buildButton("+", Colors.orange, model),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildButton("1", Colors.blue, model),
                _buildButton("2", Colors.blue, model),
                _buildButton("3", Colors.blue, model),
                _buildButton("-", Colors.orange, model),
              ],
            ),
          ],
        ),
      ],
    );
  }
}
