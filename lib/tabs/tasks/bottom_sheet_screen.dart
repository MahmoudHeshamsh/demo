import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:todo_app/app_theme.dart';
import 'package:todo_app/compnent/com_elevated_button.dart';
import 'package:todo_app/compnent/com_text_form_field.dart';

class BottomSheetScreen extends StatefulWidget {
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
    return Container(
      decoration: BoxDecoration(
        color: AppTheme.white,
        borderRadius: BorderRadius.circular(25),
      ),
      padding: EdgeInsets.all(20),
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
            SizedBox(
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
            SizedBox(
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
                    lastDate: DateTime.now().add(Duration(days: 30)),
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
            Spacer(),
            ComElevatedButton(
                label: 'Add',
                onPressed: () {
                  if(formKey.currentState!.validate()){
                        addTask;
                  }
                })
          ],
        ),
      ),
    );
  }

  void addTask() {}
}
