import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/app_theme.dart';
import 'package:todo_app/firebase_functions.dart';
import 'package:todo_app/models/task_models.dart';
import 'package:todo_app/tabs/tasks/tasks_provider.dart';

class Tasks extends StatelessWidget {
  TaskModels task;

  Tasks(this.task);
  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
      child: Slidable(
        startActionPane: ActionPane(
          motion: const ScrollMotion(),
          dismissible: DismissiblePane(onDismissed: () {}),
          children: [
            SlidableAction(
              onPressed: (_) {
                FirebaseFunctions.deleteTaskFromFirestore(task.id)
                    .timeout(Duration(milliseconds: 100), onTimeout: () {
                  Provider.of<TasksProvider>(context,listen: false).getTasks();
                }).catchError((error){
                  Fluttertoast.showToast(
                    msg: "Something wents wrong",
                    toastLength: Toast.LENGTH_LONG,
                    timeInSecForIosWeb: 5,
                    backgroundColor: Colors.grey,
                    textColor: Colors.white,
                    fontSize: 16.0,
                );
                });
              },
              backgroundColor: AppTheme.red,
              foregroundColor: AppTheme.white,
              icon: Icons.delete,
              label: 'Delete',
            ),
          ],
        ),
        child: Container(
          padding: const EdgeInsets.all(20),
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
        ),
      ),
    );
  }
}
