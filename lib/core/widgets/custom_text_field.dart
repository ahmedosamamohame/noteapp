import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    super.key,
    required this.controller,
    required this.hint,
    this.maxLines = 1,
    this.autofocus = false,
  });

  final TextEditingController controller;
  final String hint;
  final int maxLines;
  final bool autofocus;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      maxLines: maxLines,
      autofocus: autofocus,
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(hintText: hint),
      validator: (value) =>
          (value == null || value.trim().isEmpty) ? 'This field is required' : null,
    );
  }
}
