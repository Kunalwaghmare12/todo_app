import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:to_do_app/Models/todo_model.dart';

class TaskService {
  static const getApiUrl = 'https://api.nstack.in/v1/todos?page=1&limit=20';
  static const postApiUrl = 'https://api.nstack.in/v1/todos';
  static const deleteApiUrl = 'https://api.nstack.in/v1/todos/';

  static Future<List<Map<String,dynamic>>> fetchTasks() async {
    final response = await http.get(Uri.parse(getApiUrl));
    print("get : ${response.statusCode}");
    print(response.body);
    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      // return TodoModel.fromJson(data);
      var items = List<Map<String, dynamic>>.from(data['items']);
      return items;
    } else {
      throw Exception("Failed to load items");
    }
  }


  static Future<TodoModel> addTask(TodoModel todoModel) async {
    final response = await http.post(
      Uri.parse(postApiUrl),
      body: jsonEncode(todoModel.toJson()),
      headers: {
        'Content-Type': 'application/json',
        'accept': 'application/json'
      },
    );
    if (response.statusCode == 201) {
      print(response.body);
      return TodoModel.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to add task');
    }
  }

  static Future<void> deleteTask(String id) async {
    final response = await http.delete(Uri.parse('$deleteApiUrl$id'));
    print("delete : ${response.statusCode}");
    if (response.statusCode != 200) {
      throw Exception("Failed to delete task");
    }
  }
}
