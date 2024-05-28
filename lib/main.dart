import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do_app/Models/todo_model.dart';
import 'package:to_do_app/Pages/edit_task_page.dart';
import 'package:to_do_app/Repository/todo_repo.dart';
import 'Bloc/todo_bloc.dart';
import 'Pages/add_task_page.dart';
import 'Pages/home_page.dart';
import 'Services/todo_services.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<TodoBloc>(
          create: (context) => TodoBloc(TodoRepo(TodoService())),
        ),
      ],
      child: MaterialApp(
        title: 'Todo App',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        routes: {
          '/' : (context) => const MyHomePage(),
          'AddTask' : (context) => const AddTaskPage(),
          'EditTask' : (context) => EditTaskPage(oldTodo:TodoModel()),
        },
      ),
    );
  }
}
