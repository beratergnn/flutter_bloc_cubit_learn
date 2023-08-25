import 'package:api_call_using_cubit/todo/models/todo_model.dart';

abstract class TodoState {}

class InitTodoState extends TodoState {}

class LoadingTodoState extends TodoState {}

class ErrorTodoState extends TodoState {
  final String message;
  ErrorTodoState({required this.message, required});
}

class ResponseTodoState extends TodoState {
  final List<TodoModel> todos;

  ResponseTodoState({required this.todos});
}
