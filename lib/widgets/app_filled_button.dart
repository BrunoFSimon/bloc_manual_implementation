import 'package:flutter/material.dart';

class AppFilledButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;

  const AppFilledButton({
    super.key,
    required this.text,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return FilledButton(onPressed: onPressed, child: Text(text));
  }
}
