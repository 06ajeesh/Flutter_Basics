
import 'package:flutter/material.dart';

class YellowButton extends StatelessWidget {
  final String label;
  final Function() onPressed;
  final double width;

  const YellowButton({
    super.key,
    required this.label,
    required this.width,
    required this.onPressed,
    this.customFont = false,
    this.colour = Colors.yellow,
    this.fontweigh = FontWeight.normal,
  });
  final bool customFont;
  final FontWeight fontweigh;
  final Color colour;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 30,
      width: MediaQuery.of(context).size.width * width,
      decoration:
          BoxDecoration(color: colour, borderRadius: BorderRadius.circular(10)),
      child: MaterialButton(
        onPressed: onPressed,
        child: Center(
            child: Text(
          label,
          style: TextStyle(
            fontFamily: customFont == true ? 'Acme' : 'DefaultFont',
            fontWeight: fontweigh,
          ),
        )),
      ),
    );
  }
}
