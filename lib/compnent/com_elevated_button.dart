import 'package:flutter/material.dart';
import 'package:todo_app/app_theme.dart';

class ComElevatedButton extends StatelessWidget {
  String label;
  VoidCallback onPressed;
  Color color;

  ComElevatedButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.color = AppTheme.primary,
  });
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
      ),
      onPressed: onPressed,
      child: Text(
        label,
        style: Theme.of(context)
            .textTheme
            .titleMedium
            ?.copyWith(color: AppTheme.white),
      ),
    );
  }
}
