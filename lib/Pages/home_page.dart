import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do_app/Bloc/todo_bloc.dart';
import 'package:to_do_app/Models/todo_model.dart';



class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<TodoBloc>(context).add(TodoLoadedEvent());
  }

  // void goToEditPage(BuildContext context, TodoModel todoModel){
  //   Navigator.pushNamed(context,'AddTask')
  // }

  DateTime dateTime =DateTime.now();


  @override
  Widget build(BuildContext context) {
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
            left: 10,
            right:10,
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
              child: BlocBuilder<TodoBloc, TodoState>(
                builder: (context, state){
                  if(state is TodoInitial){
                    return const Center(child: CircularProgressIndicator(),);
                  }
                  else if(state is TodoLoadedState){
                      return ListView.builder(
                          itemCount: state.tasks.length,
                          itemBuilder: (context, index) {
                            TodoModel todo = state.tasks[index];
                            return Card(
                              margin: const EdgeInsets.all(5),
                              elevation: 3,
                              child: ListTile(
                                leading: CircleAvatar(child: Text("${index + 1}")),
                                title: Text("Title : ${todo.title}"),
                                subtitle: Column(
                                  children: [
                                    Text(
                                        "Description : ${todo.description}"),
                                    // SizedBox(height: 4,),
                                    Text("${DateTime.now()}"),
                                  ],
                                ),
                                trailing:
                                Row(mainAxisSize: MainAxisSize.min, children: [
                                  IconButton(
                                    icon: const Icon(
                                      Icons.delete, color: Colors.red,),
                                    onPressed: (){
                                      BlocProvider.of<TodoBloc>(context).add(TodoDeleteEvent("${todo.sId}"));
                                    },
                                  ),
                                  const SizedBox(
                                      width: 1),
                                  IconButton(
                                      icon: const Icon(Icons.edit),
                                      onPressed: () {
                                       Navigator.pushNamed(context,'EditTask');
                                      }),
                                ]),
                              ),
                            );
                          });
                    }else if(state is TodoErrorState){
                    return Center(child: Text(state.errorMessage),);
                  }else{
                    return Container();
                  }
                },
              ),
            ))
      ]),
      floatingActionButton: FloatingActionButton(
        // onPressed: goToAddTaskPage,
        onPressed: () {
          Navigator.pushNamed(context, "AddTask");
        },
        backgroundColor: Colors.green,
        child: const Icon(Icons.add),
      ),
    );
  }
}
