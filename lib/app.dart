import 'package:flutter/material.dart';
import 'package:task_manager_live_app/UI/Screens/spashScreen.dart';

class TaskManagerApp extends StatelessWidget {
  const TaskManagerApp({Key? key}) : super(key: key);

  static GlobalKey<NavigatorState> navigationKey = GlobalKey<NavigatorState>();


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: navigationKey,
      home: SplashScreen(),
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        inputDecorationTheme: InputDecorationTheme(
            fillColor: Colors.white,
            filled: true,
            border: OutlineInputBorder(
              borderSide: BorderSide.none,
            ),
            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide.none
            )
        ),
        textTheme: TextTheme(
          titleLarge: TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.w600
          ),
        ),
        primaryColor: Colors.green,
        primarySwatch: Colors.green,
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            padding: EdgeInsets.symmetric(vertical: 10),
          )
        )
      ),
    );
  }
}
