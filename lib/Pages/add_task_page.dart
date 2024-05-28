import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:to_do_app/Models/api_service.dart';
import '../Bloc/todo_bloc.dart';
import '../Models/todo_model.dart';

class AddTaskPage extends StatefulWidget {
  const AddTaskPage({super.key});


  @override
  State<AddTaskPage> createState() => AddTaskPageState();
}

class AddTaskPageState extends State<AddTaskPage> {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();



  void submitData() async{
    final TodoBloc todoBloc = BlocProvider.of<TodoBloc>(context);

    try{
          if(formKey.currentState!.validate()) {
            todoBloc.add(AddTodoEvent(TodoModel(
                title: titleController.text,
                description: descController.text,
                isCompleted: false
            )));
            titleController.clear();
            descController.clear();
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Task Added successfully.'),
                duration: Duration(seconds: 1),
              ),
            );

            // BlocProvider.of<TodoBloc>(context).add(TodoLoadedEvent());
            todoBloc.add(TodoLoadedEvent());
          }
        }catch(e){
          throw Exception("Unable to submit data");
        }
      }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lightGreen,
        title: const Text("Add Task"),
      ),
      body: BlocBuilder<TodoBloc, TodoState>(
        builder: (context, state) {
          return Form(
            key: formKey,
            child: Column(
              children: [
                const SizedBox(
                  height: 10,
                ),
                Card(
                  child: TextFormField(
                    controller: titleController,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Please Enter Title";
                      } else {}
                    },
                    decoration: const InputDecoration(
                      labelText: 'Task Name',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Card(
                  child: TextFormField(
                    minLines: 5,
                    maxLines: 8,
                    controller: descController,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Please Enter description";
                      }
                    },
                    decoration: const InputDecoration(
                      labelText: 'description',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                const SizedBox(
                  height: 10,
                ),
                ElevatedButton(
                  onPressed:()=>submitData(),
                  style: ButtonStyle(
                      minimumSize:
                      MaterialStateProperty.all<Size>(const Size(200, 70))),
                  child: const Text(
                    "Save",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
