import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  final String label;
  final double width;
  final Function() onpressed;
  const MyButton({
    super.key,
    required this.label,
    required this.width,
    required this.onpressed,
    this.textColor = Colors.black,
    this.backgroundColor = Colors.yellow,
    this.hight = 30,
    this.radius = 10,
    this.family = 'DefaultFont',
    this.size = 20,
  });
  final Color textColor;
  final Color backgroundColor;
  final double hight;
  final String family;
  final double radius;
  final double size;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: hight,
      width: width,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(radius),
      ),
      child: MaterialButton(
        onPressed: onpressed,
        child: Center(
          child: Text(
            label,
            style: TextStyle(
              fontFamily: family,
              color: textColor,
              fontSize: size,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
