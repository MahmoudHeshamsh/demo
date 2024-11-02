import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/app_theme.dart';
import 'package:todo_app/compnent/com_elevated_button.dart';
import 'package:todo_app/compnent/com_text_form_field.dart';
import 'package:todo_app/firebase_functions.dart';
import 'package:todo_app/models/task_models.dart';
import 'package:todo_app/tabs/tasks/tasks_provider.dart';

class Tasks extends StatefulWidget {
  TaskModels task;

  Tasks(this.task);

  @override
  State<Tasks> createState() => _TasksState();
}

class _TasksState extends State<Tasks> {
  TextEditingController newTitleController = TextEditingController();
  TextEditingController newDescriptionController = TextEditingController();
  bool isEditActive = false;

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
      child: Column(
        children: [
          Slidable(
            key: ValueKey(widget.task.id.hashCode),
            startActionPane: ActionPane(
              motion: const ScrollMotion(),
              dismissible: DismissiblePane(onDismissed: () {}),
              children: [
                SlidableAction(
                  onPressed: (_) {
                    FirebaseFunctions.deleteTaskFromFirestore(widget.task.id)
                        .timeout(Duration(milliseconds: 100), onTimeout: () {
                      Provider.of<TasksProvider>(context, listen: false)
                          .getTasks();
                    }).catchError((error) {
                      Fluttertoast.showToast(
                        msg: "Something went wrong",
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
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      bottomLeft: Radius.circular(10)),
                ),
                SlidableAction(
                  onPressed: (_) {
                    setState(() {
                      isEditActive = !isEditActive;
                      newTitleController.text =
                          widget.task.title; 
                      newDescriptionController.text = widget.task.description;
                    });
                  },
                  backgroundColor: AppTheme.gray,
                  foregroundColor: AppTheme.white,
                  icon: Icons.edit,
                  label: 'Edit',
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(10),
                      bottomRight: Radius.circular(10)),
                ),
              ],
            ),
            child: Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                  color: AppTheme.white,
                  borderRadius: BorderRadius.circular(15)),
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
                        widget.task.title,
                        style: theme.textTheme.titleMedium
                            ?.copyWith(color: AppTheme.primary),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        widget.task.description,
                        style: theme.textTheme.titleSmall,
                      ),
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
                  ),
                ],
              ),
            ),
          ),
          if (isEditActive)
            Container(
              margin: EdgeInsets.only(top: 10),
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                  color: AppTheme.white,
                  borderRadius: BorderRadius.circular(10)),
              child: Column(
                children: [
                  ComTextFormField(
                    controller: newTitleController,
                    hintText: 'Edit Task',
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Please enter a task';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 8),
                  ComTextFormField(
                    controller: newDescriptionController,
                    hintText: 'Edit Description',
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Please enter a description';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      ComElevatedButton(
                        label: 'Save',
                        onPressed: () {
                          FirebaseFunctions.updateTaskFromFirestore(
                            widget.task.id,
                            newTitleController.text,
                            newDescriptionController.text,
                          ).timeout(
                            Duration(microseconds: 100),
                            onTimeout: () {
                              setState(() {
                                widget.task.title = newTitleController.text;
                                widget.task.description =
                                    newDescriptionController.text;
                                isEditActive = !isEditActive;
                                Provider.of<TasksProvider>(context, listen: false)
                          .getTasks();
                              });
                            },
                          ).catchError((error) {
                            Fluttertoast.showToast(
                              msg: "Failed to update task",
                              toastLength: Toast.LENGTH_LONG,
                              backgroundColor: Colors.red,
                              textColor: Colors.white,
                            );
                          });
                        },
                      ),
                      ComElevatedButton(
                        label: 'Cancel',
                        onPressed: () {
                          setState(() {
                            isEditActive = !isEditActive;
                          });
                        },
                        color: AppTheme.red,
                      )
                    ],
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}
