import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyAlertDialog {
  static void showMyDialog(
      {required BuildContext context,
      required String title,
      required String content,
      required Function() tapNo,
      required Function() tapYes}) {
    showCupertinoDialog(
        context: context,
        builder: (context) {
          return CupertinoAlertDialog(
            title: Text(
              title,
              style: const TextStyle(color: Colors.red),
            ),
            content: Text(content),
            actions: [
              CupertinoDialogAction(
                onPressed: tapNo,
                child: const Text("Cancel"),
              ),
              CupertinoDialogAction(
                isDestructiveAction: true,
                onPressed: tapYes,
                child: const Text("Continue"),
              )
            ],
          );
        });
  }
}
