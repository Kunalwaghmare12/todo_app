import 'package:to_do_app/Models/todo_model.dart';
import 'package:to_do_app/Services/todo_services.dart';

class TodoRepo{
  final TodoService todoService;
  late List<Map<String,dynamic>> taskList = [];

  TodoRepo(this.todoService);
  Future<void> addTodo (TodoModel todoModel)async{
    await todoService.postTask(todoModel);
  }

  Future<List<TodoModel>> getTodo() async{
    taskList = await todoService.getTask();
    return taskList.map((data) => TodoModel.fromJson(data)).toList();
  }

  Future<void> delTask(String id) async{
  await todoService.deleteTask(id);
  }

  Future<void> editTodo(String id,TodoModel updatedTask) async{
    await todoService.editTask(id,updatedTask);


  }
}