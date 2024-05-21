import 'package:flutter/material.dart';
import 'package:to_do_app/Models/api_service.dart';

import 'addTask_page.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Map<String, dynamic>> showtasks = [];
  @override
  void initState() {
    super.initState();
    fetchTasks();
  }

  goToAddTaskPage() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AddTaskPage(onTaskAdded: fetchTasks,),
      ),
    );
  }

  Future<void> fetchTasks() async {
    try {
      List<Map<String, dynamic>> tasks = await TaskService.fetchTasks();
      setState(() {
        showtasks = tasks;
      });
    } catch (e) {
      throw Exception("unable to fetch");
    }
  }

  void editTask() {}
  deleteTask(String id) async{
    try{
      await TaskService.deleteTask(id);
      setState(() {
        fetchTasks();
      });

    }catch(e){
      throw Exception("unable to delete task");
    }
  }

  @override
  Widget build(BuildContext context) {
    print("build");
    return Scaffold(
      appBar: AppBar(
        leading: const Icon(Icons.task),

        backgroundColor: Colors.lightGreen,
        title: const Text("To-Do App")
      ),
      body: Stack(children: [
        Container(
          alignment: Alignment.topCenter,
          height: double.infinity,
          width: double.infinity,
          decoration: const BoxDecoration(color: Colors.lightBlueAccent),
          child: const Padding(
            padding: EdgeInsets.all(25.0),
            child: Text(
              "All Tasks ",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
          ),
        ),
        Positioned(
            top: 90,
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              decoration: BoxDecoration(
                boxShadow: [BoxShadow(color: Colors.white.withOpacity(0.7))],
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
                color: Colors.white,
              ),
              child:ListView.builder(
                  itemCount: showtasks.length,
                  itemBuilder: (context, index) {
                    String id=showtasks[index]['_id'];
                    return Card(
                      margin: const EdgeInsets.all(5),
                      elevation: 3,
                      child: ListTile(
                        leading: CircleAvatar(child: Text("${index + 1}")),
                        title: Text("Title : ${showtasks[index]['title']}"),
                        subtitle: Text(
                            "Description : ${showtasks[index]['description']}"),
                        trailing:
                        Row(mainAxisSize: MainAxisSize.min, children: [
                          IconButton(
                            icon: const Icon(Icons.delete,color: Colors.red,),
                            onPressed: ()=>deleteTask(id),
                          ),
                          const SizedBox(
                              width: 1),
                          IconButton(
                              icon: const Icon(Icons.edit),
                              onPressed: editTask)
                        ]),
                      ),
                    );
                  }),
            ))
      ]),
      floatingActionButton: FloatingActionButton(
        onPressed: goToAddTaskPage,
        backgroundColor: Colors.green,
        child: const Icon(Icons.add),
      ),
    );
  }
}
