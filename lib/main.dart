import 'package:flutter/material.dart';
import 'Pages/addTask_page.dart';
import 'Pages/home_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Todo App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      routes: {
        '/' : (context) => const MyHomePage(),
        'AddTask' : (context) => AddTaskPage(onTaskAdded: () {  },),

      },
    );
  }
}
