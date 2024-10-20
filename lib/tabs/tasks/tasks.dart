import 'package:flutter/material.dart';
import 'package:todo_app/app_theme.dart';

class Tasks extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return Container(
      padding: EdgeInsets.all(20),
      margin: EdgeInsets.symmetric(vertical: 8,horizontal: 20),
      decoration: BoxDecoration(
        color: AppTheme.white,
        borderRadius: BorderRadius.circular(15)
      ),
      child: Row(
        children: [
          Container(
            margin: EdgeInsetsDirectional.only(end: 8),
            decoration: BoxDecoration(
              color: theme.primaryColor,
              borderRadius: BorderRadius.circular(10)
            ),
            height: 62,
            width: 4,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'play football',
                style: theme.textTheme.titleMedium?.copyWith(
                  color: AppTheme.primary
                ),
                ),
                SizedBox(height: 4,),
              Text(
                'task description',
                style: theme.textTheme.titleSmall,
                )
            ],
          ),
          Spacer(),
          Container(
            decoration: BoxDecoration(
              color: AppTheme.primary,
              borderRadius: BorderRadius.circular(10)
            ),
            width: 69,
            height: 34,
            child: Icon(
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