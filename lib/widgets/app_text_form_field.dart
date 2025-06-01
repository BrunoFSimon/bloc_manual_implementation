import 'package:flutter/material.dart';

class AppTextFormField extends StatelessWidget {
  final void Function(String) onChanged;
  final String label;
  final String hint;
  final String? initialValue;
  final String? errorText;

  const AppTextFormField({
    super.key,
    required this.onChanged,
    required this.hint,
    required this.label,
    required this.initialValue,
    required this.errorText,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onChanged: onChanged,
      initialValue: initialValue,
      forceErrorText: errorText,
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        border: OutlineInputBorder(),
      ),
    );
  }
}
