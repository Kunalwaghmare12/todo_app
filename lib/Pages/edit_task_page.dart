import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../Bloc/todo_bloc.dart';
import '../Models/todo_model.dart';

class EditTaskPage extends StatefulWidget {
  final TodoModel oldTodo;

  const EditTaskPage({super.key, required this.oldTodo});
  @override
  State<EditTaskPage> createState() => EditTaskPageState();
}

class EditTaskPageState extends State<EditTaskPage> {
  late TextEditingController _titleController=TextEditingController();
  late TextEditingController _descController=TextEditingController();

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text:widget.oldTodo.title);
    _descController = TextEditingController(text: widget.oldTodo.description);
  }

  void editedTaskSubmit() {
    final TodoBloc todoBloc = BlocProvider.of<TodoBloc>(context);
    TodoModel updatedTask = TodoModel(
      title: _titleController.text,
      description: _descController.text,
      isCompleted : false
    );
    todoBloc.add(TodoEditEvent(widget.oldTodo.sId.toString(), updatedTask));
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      content: Text("Changes Saved Successfully"),
      duration: Duration(seconds: 1),
    ));
    _titleController.clear();
    _descController.clear();


    // BlocProvider.of<TodoBloc>(context).add(TodoEditEvent(widget.oldTodo.sId.toString(), editedTask));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lightGreen,
        title: const Text("Edit Task"),
      ),
      body: Form(
        child: Column(
          children: [
            const SizedBox(height: 10),
            Card(
              child: TextFormField(
                controller: _titleController,
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Please Enter Title";
                  } else {
                    return null;
                  }
                },
                decoration: const InputDecoration(
                  labelText: 'Task Name',
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            const SizedBox(height: 10),
            Card(
              child: TextFormField(
                minLines: 5,
                maxLines: 8,
                controller: _descController,
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Please Enter Description";
                  } else {
                    return null;
                  }
                },
                decoration: const InputDecoration(
                  labelText: 'Description',
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: editedTaskSubmit,
              style: ButtonStyle(
                minimumSize: WidgetStateProperty.all<Size>(const Size(200, 70)),
              ),
              child: const Text(
                "Save Changes",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
