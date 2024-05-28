
import 'dart:convert';

import '../Models/todo_model.dart';
import 'package:http/http.dart' as http;

class TodoService {

  final String postUrl ="https://api.nstack.in/v1/todos";
  final String getUrl ="https://api.nstack.in/v1/todos?page=1&limit=20";
  final String deleteUrl ="https://api.nstack.in/v1/todos/";
  final String editUrl ="https://api.nstack.in/v1/todos/";

  Future<TodoModel> postTask(TodoModel todoModel)async {
    final response = await http.post(Uri.parse(postUrl),body:jsonEncode(todoModel.toJson()),headers:{
      'Content-Type': 'application/json',
      'accept': 'application/json'
    } );

    if(response.statusCode==201){
      return TodoModel.fromJson(jsonDecode(response.body));
    }else{
      throw Exception("Failed to add task");
    }
  }


  Future<List<Map<String,dynamic>>> getTask() async {
    final response =await http.get(Uri.parse(getUrl));
    if(response.statusCode == 200){
      var data = json.decode(response.body);
      var tasks = List<Map<String,dynamic>>.from(data['items']);
      return tasks;
    }else{
      throw Exception("Failed to Load Tasks");
    }
  }

  Future<void> deleteTask(String id) async {
    final response = await http.delete(Uri.parse('$deleteUrl$id'));
    if (response.statusCode != 200) {
      throw Exception("Failed to delete task");
    }
  }

  Future<TodoModel> editTask(TodoModel oldTask) async {
    final editUrlWithId = '$editUrl${oldTask.sId}';
    final response = await http.put(
      Uri.parse(editUrlWithId),
      body: jsonEncode(oldTask.toJson()),
      headers: {
        'Content-Type': 'application/json',
        'accept': 'application/json'
      },
    );

    if (response.statusCode == 200) {
      return TodoModel.fromJson(jsonDecode(response.body));
    } else {
      throw Exception("Failed to edit task");
    }
  }




}
