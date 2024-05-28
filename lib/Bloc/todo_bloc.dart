
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do_app/Models/todo_model.dart';

import '../Repository/todo_repo.dart';

part 'todo_event.dart';
part 'todo_state.dart';

class TodoBloc extends Bloc<TodoEvent, TodoState> {
  final TodoRepo todoRepo;
  TodoBloc(this.todoRepo) : super(TodoInitial()){



    on<AddTodoEvent>((event,emit) async{
      try{
        await todoRepo.addTodo(event.todoModel);
        List<TodoModel> tasks =
        await todoRepo.getTodo();//
        emit(TodoLoadedState(tasks)); //
      }catch(e){
        emit(TodoErrorState("Failed to Add data"));
      }
    });

    on<TodoLoadedEvent>((event, emit)async{
      try{
        List<TodoModel> tasks =
        await todoRepo.getTodo();
        emit(TodoLoadedState(tasks));
      }catch(e){
        emit(TodoErrorState("Failed to Load Todos"));
      }
    });

    on<TodoDeleteEvent>((event,emit)async {
      try{
        await todoRepo.delTask(event.id);
        List<TodoModel> tasks =
        await todoRepo.getTodo();
        emit(TodoLoadedState(tasks));

      }catch(e){
        emit(TodoErrorState("Error while Deleting"));
      }
    });

    on<TodoEditEvent>((event,emit)async {
      try{
          await todoRepo.editTodo(event.id,event.updatedModel);
          List<TodoModel> tasks =
          await todoRepo.getTodo();
          emit(TodoLoadedState(tasks));
      }catch(e){
        throw Exception("Error while Editing");
      }
    });


  }


}
