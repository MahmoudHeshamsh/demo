import 'package:flutter/material.dart';
import 'package:todo_app/firebase_functions.dart';
import 'package:todo_app/models/task_models.dart';

class TasksProvider with ChangeNotifier {
  List<TaskModels> tasks = [];
  DateTime selectedDate = DateTime.now();

  Future<void> getTasks(String userId) async {
    tasks = await FirebaseFunctions.getTasksFromFireStore(userId);
    tasks = tasks.where(
      (task) =>
       task.date.year == selectedDate.year &&
       task.date.month == selectedDate.month &&
       task.date.day == selectedDate.day        
       ).toList();
    notifyListeners();
  }

  void changeSelectedDate(DateTime date) {
    selectedDate = date;
    notifyListeners();
  }
}
