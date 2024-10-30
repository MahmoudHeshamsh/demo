import 'package:flutter/material.dart';
import 'package:todo_app/app_theme.dart';

class ComTextFormField extends StatefulWidget {
  TextEditingController controller;
  String hintText;
  String? Function(String?)? validator;
  bool isPassward;

  ComTextFormField({
    super.key,
    required this.controller,
    required this.hintText,
    required this.validator,
    this.isPassward = false,
  });

  @override
  State<ComTextFormField> createState() => _ComTextFormFieldState();
}

class _ComTextFormFieldState extends State<ComTextFormField> {
  late bool isVisible = widget.isPassward;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      validator: widget.validator,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      obscureText: isVisible,
      decoration: InputDecoration(
        hintText: widget.hintText,
        suffixIcon: widget.isPassward
            ? IconButton(
                onPressed: () {
                  isVisible = !isVisible;
                  setState(() {});
                },
                icon:isVisible? Icon(Icons.visibility_off_outlined) : Icon(Icons.visibility_outlined),
              )
            : null,
        hintStyle: Theme.of(context)
            .textTheme
            .titleSmall
            ?.copyWith(color: AppTheme.gray),
      ),
    );
  }
}
