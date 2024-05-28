part of 'todo_bloc.dart';

abstract class TodoState {}

final class TodoInitial extends TodoState {}

class TodoAddedState extends TodoState{

}

class TodoErrorState extends TodoState{
  final String errorMessage;
  TodoErrorState(this.errorMessage);
}


class TodoLoadedState extends TodoState{
final List<TodoModel> tasks;
TodoLoadedState(this.tasks);
}