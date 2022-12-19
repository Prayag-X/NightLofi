import 'package:flutter/material.dart';

Size screenSize(context) => MediaQuery.of(context).size;
double statusBarSize(context) => MediaQuery.of(context).viewPadding.top;

void nextScreen(context, String pageName) {
  Navigator.pushNamed(context, '/$pageName');
}

void nextScreenReplace(context, String pageName) {
  Navigator.pushReplacementNamed(context, '/$pageName');
}

void nextScreenOnly(context, String pageName) {
  Navigator.of(context)
      .pushNamedAndRemoveUntil('/$pageName', ModalRoute.withName('/'));
}

void screenPop(context) {
  Navigator.of(context).pop();
}

void showSnackBar(context, String message, int duration) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(
        message,
        style: const TextStyle(
          fontSize: 14,
          color: Colors.white
        ),
      ),
      backgroundColor: Colors.black54,
      duration: Duration(seconds: duration),
    ),
  );
}
