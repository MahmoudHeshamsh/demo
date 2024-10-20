import 'package:flutter/material.dart';
import 'package:todo_app/app_theme.dart';
import 'package:todo_app/tabs/settings/settings_tab.dart';
import 'package:todo_app/tabs/tasks/tasks_tab.dart';

class HomeScreen extends StatefulWidget {
  static const String routeName = '/home_screen';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  void selectedScreen(int index) {
    setState(() {
      current_index = index;
    });
  }

  List<Widget> tabs = [
    TasksTab(),
    SettingsTab(),
  ];

  int current_index = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: tabs[current_index],
      bottomNavigationBar: BottomAppBar(
        shape: CircularNotchedRectangle(),
        notchMargin: 10,
        clipBehavior: Clip.antiAliasWithSaveLayer,
        padding: EdgeInsets.zero,
        color: AppTheme.white,
        child: BottomNavigationBar(
          elevation: 0,
          currentIndex: current_index,
          onTap: selectedScreen,
          items: [
            BottomNavigationBarItem(icon: Icon(Icons.list), label: 'List'),
            BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Settings')
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){},
        child: Icon(
        Icons.add,
        size: 32,
        ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
