import 'package:flutter/material.dart';
import 'package:todo_app/app_theme.dart';

class ComTextFormField extends StatelessWidget {
  TextEditingController controller;
  String hintText;
  String? Function(String?)? validator;

  ComTextFormField({
    required this.controller,
    required this.hintText,
    required this.validator,
  });
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      validator: validator,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: Theme.of(context).textTheme.titleSmall?.copyWith(
          color: AppTheme.gray
        ),
      ),
    );
  }
}
