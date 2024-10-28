import 'package:flutter/material.dart';
import 'package:todo_app/firebase_functions.dart';
import 'package:todo_app/models/task_models.dart';

class TasksProvider with ChangeNotifier {
  List<TaskModels> tasks = [];

  Future<void> getTasks() async {
    tasks = await FirebaseFunctions.getTasksFromFireStore();
    notifyListeners();
  }
}
