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
  // EditTaskPageState(this.oldTask);

  late TextEditingController titleController=TextEditingController();
  late TextEditingController descController=TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    print('oldTodo: ${widget.oldTodo}');
    print('oldTodo title: ${widget.oldTodo.title}');
    print('oldTodo description: ${widget.oldTodo.description}');
    titleController.text =widget.oldTodo.title.toString();
    descController.text = widget.oldTodo.description.toString();
  }

  void editedTaskSubmit(TodoModel oldTodo) {
    final TodoBloc todoBloc = BlocProvider.of<TodoBloc>(context);
    TodoModel editedTask = TodoModel(
      sId: widget.oldTodo.sId,
      title: titleController.text,
      description: descController.text,
    );
    todoBloc.add(TodoEditEvent(widget.oldTodo.sId.toString(), editedTask));
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TodoBloc, TodoState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.lightGreen,
            title: const Text("Edit Task"),
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
                      onPressed: () {},
                      style: ButtonStyle(
                          minimumSize:
                          MaterialStateProperty.all<Size>(const Size(200, 70))),
                      child: const Text(
                        "Save Changes",
                        style: TextStyle(fontSize: 20,
                            fontWeight: FontWeight.bold),
                      ),
                    )
                  ],
                ),
              );
            },
          ),
        );
      },
    );
  }
}
