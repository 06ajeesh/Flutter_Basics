import 'package:flutter/material.dart';

class GoogleFacebookLogin extends StatelessWidget {
  String? label;
  final Function() onPressed;
  final Widget child;

  GoogleFacebookLogin({
    super.key,
    required this.child,
    this.label,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: InkWell(
        onTap: onPressed,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 30,
              width: 30,
              child: child,
            ),
            label != null
                ? Text(
                    label!,
                    style: TextStyle(
                      color: Colors.black87.withOpacity(0.7),
                      fontFamily: 'Akaya',
                      fontWeight: FontWeight.bold,
                    ),
                  )
                : const SizedBox(
                    height: 0,
                    width: 0,
                  )
          ],
        ),
      ),
    );
  }
}
