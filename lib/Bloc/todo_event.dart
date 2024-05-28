part of 'todo_bloc.dart';

abstract class TodoEvent {}

class AddTodoEvent extends TodoEvent{
  final TodoModel todoModel;
  AddTodoEvent(this.todoModel);
}

class TodoLoadedEvent extends TodoEvent{

}

class TodoDeleteEvent extends TodoEvent{
  final String id;
  TodoDeleteEvent(this.id);
}


class TodoEditEvent extends TodoEvent{
  final String id;
  final TodoModel updatedModel;
  TodoEditEvent(this.id,this.updatedModel);
}
