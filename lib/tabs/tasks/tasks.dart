import 'package:flutter/material.dart';
import 'package:todo_app/app_theme.dart';
import 'package:todo_app/models/task_models.dart';

class Tasks extends StatelessWidget {
  TaskModels task;

  Tasks(this.task);
  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.all(20),
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
      decoration: BoxDecoration(
          color: AppTheme.white, borderRadius: BorderRadius.circular(15)),
      child: Row(
        children: [
          Container(
            margin: const EdgeInsetsDirectional.only(end: 8),
            decoration: BoxDecoration(
                color: theme.primaryColor,
                borderRadius: BorderRadius.circular(10)),
            height: 62,
            width: 4,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                task.title,
                style: theme.textTheme.titleMedium
                    ?.copyWith(color: AppTheme.primary),
              ),
              const SizedBox(
                height: 4,
              ),
              Text(
                task.description,
                style: theme.textTheme.titleSmall,
              )
            ],
          ),
          const Spacer(),
          Container(
            decoration: BoxDecoration(
                color: AppTheme.primary,
                borderRadius: BorderRadius.circular(10)),
            width: 69,
            height: 34,
            child: const Icon(
              Icons.check,
              size: 32,
              color: AppTheme.white,
            ),
          )
        ],
      ),
    );
  }
}
