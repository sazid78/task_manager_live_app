import 'package:flutter/material.dart';
import 'package:task_manager_live_app/UI/Screens/cancel_task_screen.dart';
import 'package:task_manager_live_app/UI/Screens/complited_task_screen.dart';
import 'package:task_manager_live_app/UI/Screens/new_task_screen.dart';
import 'package:task_manager_live_app/UI/Screens/progress_task_screen.dart';

class MainBottomNavScreen extends StatefulWidget {
  const MainBottomNavScreen({Key? key}) : super(key: key);

  @override
  State<MainBottomNavScreen> createState() => _MainBottomNavScreenState();
}

class _MainBottomNavScreenState extends State<MainBottomNavScreen> {

  int _selectedIndex = 0;
  final List<Widget> _screens = [
    NewTaskScreen(),
    ProgressTaskScreen(),
    ComplitedTaskScreen(),
    CancelTaskScreen()
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Colors.green,
          unselectedItemColor: Colors.grey,
          showUnselectedLabels: true,
          currentIndex: _selectedIndex,
          onTap: (index){
          _selectedIndex = index;
          setState(() {

          });
          },
          items: [
            BottomNavigationBarItem(icon: Icon(Icons.add),label: "New"),
            BottomNavigationBarItem(icon: Icon(Icons.add_call),label: "In Progress"),
            BottomNavigationBarItem(icon: Icon(Icons.done_outline_outlined),label: "Complited"),
            BottomNavigationBarItem(icon: Icon(Icons.close),label: "Cancel"),
          ],
      ),
      body: _screens[_selectedIndex],
    );
  }
}
