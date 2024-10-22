import 'package:flutter/material.dart';
import 'package:todo_app/app_theme.dart';

class ComElevatedButton extends StatelessWidget {
  String label;
  VoidCallback onPressed;

  ComElevatedButton({required this.label, required this.onPressed});
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      child: Text(
        label,
        style: Theme.of(context).textTheme.titleMedium?.copyWith(
          color: AppTheme.white
        ),
        ),
    );
  }
}
