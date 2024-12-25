import 'package:flutter/material.dart';

class Utility {
  static void stateLoader(BuildContext context) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return const Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(
              strokeWidth: 2,
            ),
          ],
        );
      },
    );
  }
}
