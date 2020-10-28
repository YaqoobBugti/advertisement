import 'package:flutter/material.dart';

class MyTextField extends StatelessWidget {
  final TextEditingController controller;
  final bool obscureText;
  final TextInputType textInputType;
  final String labelText;
  MyTextField(
      {@required this.textInputType,
      @required this.controller,
      @required this.obscureText,
      @required this.labelText});
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: textInputType,
      controller: controller,
      obscureText: obscureText,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        labelText: labelText,
      ),
    );
  }
}
