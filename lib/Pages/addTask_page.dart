import 'package:flutter/material.dart';
import 'package:to_do_app/Models/api_service.dart';
import '../Models/todo_model.dart';

class AddTaskPage extends StatefulWidget {
  final VoidCallback onTaskAdded;
  const AddTaskPage({super.key, required this.onTaskAdded});

  @override
  State<AddTaskPage> createState() => AddTaskPageState();
}

class AddTaskPageState extends State<AddTaskPage> {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  late TodoModel todoModel;
  void submitData() async{
    try{
      if(formKey.currentState!.validate()) {
        todoModel = TodoModel(
            title: titleController.text,
            description: descController.text,
            isCompleted: false);
        await TaskService.addTask(todoModel);
        titleController.clear();
        descController.clear();
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Task Added successfully.'),
            duration: Duration(seconds: 1),
          ),
        );
        widget.onTaskAdded();
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
      body: Form(
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
      ),
    );
  }
}
