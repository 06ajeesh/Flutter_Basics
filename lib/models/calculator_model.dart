import 'package:flutter/foundation.dart';

class CalculatorModel extends ChangeNotifier {
  String _output = "0";
  String _operand = "";
  double _currentValue = 0;
  bool _shouldClear = false;

  String get output => _output;

  void buttonPressed(String buttonText) {
    if (buttonText == "C") {
      _output = "0";
      _operand = "";
      _currentValue = 0;
      _shouldClear = false;
    } else if (buttonText == "+" ||
        buttonText == "-" ||
        buttonText == "*" ||
        buttonText == "/") {
      if (_operand.isNotEmpty) {
        _calculate();
      } else {
        _currentValue = double.parse(_output);
      }
      _operand = buttonText;
      _shouldClear = true;
    } else if (buttonText == ".") {
      if (!_output.contains(".")) {
        _output += buttonText;
      }
    } else if (buttonText == "=") {
      _calculate();
      _operand = "";
      _shouldClear = true;
    } else {
      if (_shouldClear) {
        _output = buttonText;
        _shouldClear = false;
      } else {
        _output = _output == "0" ? buttonText : _output + buttonText;
      }
    }
    if (_output != "Error") {
      _output = double.parse(_output)
          .toStringAsFixed(2)
          .replaceFirst(RegExp(r'\.00$'), '');
    }
    notifyListeners();
  }

  void _calculate() {
    double inputValue = double.parse(_output);
    switch (_operand) {
      case "+":
        _currentValue += inputValue;
        break;
      case "-":
        _currentValue -= inputValue;
        break;
      case "*":
        _currentValue *= inputValue;
        break;
      case "/":
        if (inputValue != 0) {
          _currentValue /= inputValue;
        } else {
          _output = "Error";
          notifyListeners();
          return;
        }
        break;
    }
    _output = _currentValue.toString();
  }
}
