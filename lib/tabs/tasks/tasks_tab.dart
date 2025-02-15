import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/app_theme.dart';
import 'package:todo_app/auth/user_provider.dart';
import 'package:todo_app/tabs/settings/settings_provider.dart';
import 'package:todo_app/tabs/tasks/tasks.dart';
import 'package:easy_date_timeline/easy_date_timeline.dart';
import 'package:todo_app/firebase_functions.dart';
import 'package:todo_app/models/task_models.dart';
import 'package:todo_app/tabs/tasks/tasks_provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';


class TasksTab extends StatefulWidget {

  @override
  State<TasksTab> createState() => _TasksTabState();
}

class _TasksTabState extends State<TasksTab> {
  
  bool getTasksProvider = true;
  @override
  Widget build(BuildContext context) {
    TasksProvider tasksProvider = Provider.of<TasksProvider>(context);
    SettingsProvider settingsProvider = Provider.of<SettingsProvider>(context);

    String userId = Provider.of<UserProvider>(context,listen: false).currentUser!.id;

    if (getTasksProvider) {
      tasksProvider.getTasks(userId);
      getTasksProvider = false;
    }
    return Column(
      children: [
        Stack(
          children: [
            Container(
              height: MediaQuery.of(context).size.height * 0.20,
              width: double.infinity,
              color: AppTheme.primary,
            ),
            PositionedDirectional(
              top: MediaQuery.of(context).size.height * 0.09,
              start: 30,
              child: Text(
                AppLocalizations.of(context)!.to_do_list,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color:  settingsProvider.themeMode == ThemeMode.light? AppTheme.white : AppTheme.black,

                      fontSize: 22,
                    ),
              ),
            ),
            Padding( 
              padding: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height * 0.15),
              child: EasyInfiniteDateTimeLine(
                firstDate: DateTime.now().subtract(const Duration(days: 30)),
                focusDate: tasksProvider.selectedDate,
                lastDate: DateTime.now().add(const Duration(days: 30)),
                onDateChange: (selectedDate) {
                  tasksProvider.changeSelectedDate(selectedDate);
                  tasksProvider.getTasks(userId);
                },
                showTimelineHeader: false,
                dayProps: EasyDayProps(
                  height: 79,
                  width: 58,
                  dayStructure: DayStructure.dayStrDayNum,
                  activeDayStyle: DayStyle(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: settingsProvider.themeMode == ThemeMode.light? AppTheme.white : AppTheme.black,
),
                      dayNumStyle: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: AppTheme.primary),
                      dayStrStyle: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: AppTheme.primary)),
                  inactiveDayStyle: DayStyle(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color:  settingsProvider.themeMode == ThemeMode.light? AppTheme.white : AppTheme.black,
                                ),
                      dayNumStyle: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color:  settingsProvider.themeMode == ThemeMode.light? AppTheme.black : AppTheme.white,),
                      dayStrStyle:  TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color:  settingsProvider.themeMode == ThemeMode.light? AppTheme.black : AppTheme.white)),
                  todayStyle: DayStyle(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color:  settingsProvider.themeMode == ThemeMode.light? AppTheme.white : AppTheme.black,),
                      dayNumStyle:  TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color:  settingsProvider.themeMode == ThemeMode.light? AppTheme.black : AppTheme.white),
                      dayStrStyle: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color:  settingsProvider.themeMode == ThemeMode.light? AppTheme.black : AppTheme.white)),
                ),
              ),
            ),
          ],
        ),
        Expanded(
          child: ListView.builder(
            padding: const EdgeInsets.only(top: 5),
            itemBuilder: (_, index) => Tasks(tasksProvider.tasks[index]),
            itemCount: tasksProvider.tasks.length,
          ),
        ),
      ],
    );
  }
}
