import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/app_theme.dart';
import 'package:todo_app/compnent/com_elevated_button.dart';
import 'package:todo_app/compnent/com_text_form_field.dart';
import 'package:todo_app/firebase_functions.dart';
import 'package:todo_app/models/task_models.dart';
import 'package:todo_app/tabs/tasks/tasks_provider.dart';

class BottomSheetScreen extends StatefulWidget {
  const BottomSheetScreen({super.key});

  @override
  State<BottomSheetScreen> createState() => _BottomSheetScreenState();
}

class _BottomSheetScreenState extends State<BottomSheetScreen> {
  TextEditingController taskController = TextEditingController();

  TextEditingController discriptionController = TextEditingController();

  DateTime selectedDate = DateTime.now();

  DateFormat dateFormat = DateFormat('dd/MM/yyyy');

  var formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: Container(
        decoration: BoxDecoration(
          color: AppTheme.white,
          borderRadius: BorderRadius.circular(25),
        ),
        padding: const EdgeInsets.all(20),
        height: MediaQuery.sizeOf(context).height * 0.45,
        width: double.infinity,
        child: Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'Add new Task',
                style: Theme.of(context).textTheme.titleMedium,
                textAlign: TextAlign.center,
              ),
              ComTextFormField(
                controller: taskController,
                hintText: 'Enter your Task',
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Please enter your Task';
                  }
                  return null;
                },
              ),
              const SizedBox(
                height: 16,
              ),
              ComTextFormField(
                controller: discriptionController,
                hintText: 'Enter your description',
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Please enter your description';
                  }
                  return null;
                },
              ),
              const SizedBox(
                height: 16,
              ),
              Text(
                'Select Date : ',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              InkWell(
                onTap: () async {
                  DateTime? datetime = await showDatePicker(
                      context: context,
                      firstDate: DateTime.now(),
                      lastDate: DateTime.now().add(const Duration(days: 30)),
                      initialEntryMode: DatePickerEntryMode.calendarOnly,
                      initialDate: selectedDate);
                  setState(() {
                    if (datetime != null && datetime != selectedDate) {
                      selectedDate = datetime;
                    }
                  });
                },
                child: Text(
                  dateFormat.format(selectedDate),
                  style: Theme.of(context)
                      .textTheme
                      .titleSmall
                      ?.copyWith(color: AppTheme.gray, fontSize: 20),
                  textAlign: TextAlign.center,
                ),
              ),
              const Spacer(),
              ComElevatedButton(
                  label: 'Add',
                  onPressed: () {
                    if (formKey.currentState!.validate()) {
                      addTask();
                    }
                  })
            ],
          ),
        ),
      ),
    );
  }

  void addTask() {
    TaskModels taskModel = TaskModels(
        title: taskController.text,
        description: discriptionController.text,
        date: selectedDate);
    FirebaseFunctions.addTaskToFirestore(taskModel).timeout(
      Duration(milliseconds: 100),
      onTimeout: () {
        Navigator.of(context).pop();
        Provider.of<TasksProvider>(context,listen: false).getTasks();
        Fluttertoast.showToast(
        msg: "Tasks add succefully",
        toastLength: Toast.LENGTH_LONG,
        timeInSecForIosWeb: 5,
        backgroundColor: AppTheme.green,
        textColor: Colors.white,
        fontSize: 16.0,
    );
      },
    ).catchError((error) {
      Fluttertoast.showToast(
        msg: "Something wents wrong",
        toastLength: Toast.LENGTH_LONG,
        timeInSecForIosWeb: 5,
        backgroundColor: Colors.grey,
        textColor: Colors.white,
        fontSize: 16.0,
    );
    });
  }
}
