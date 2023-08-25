import 'package:api_call_using_cubit/repository/todo_repository.dart';
import 'package:api_call_using_cubit/todo/cubit/todo_cubit.dart';
import 'package:api_call_using_cubit/todo/views/todo_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => TodoCubit(TodoRepository()),
      child: const MaterialApp(
        home: TodoPage(),
      ),
    );
  }
}
