import 'package:api_call_using_cubit/todo/cubit/todo_cubit.dart';
import 'package:api_call_using_cubit/todo/cubit/todo_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TodoPage extends StatefulWidget {
  const TodoPage({super.key});

  @override
  State<TodoPage> createState() => _TodoPageState();
}

class _TodoPageState extends State<TodoPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      final cubit = context.read<TodoCubit>();
      cubit.fetchTodo();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: BlocBuilder<TodoCubit, TodoState>(builder: (context, state) {
        if (state is InitTodoState || state is LoadingTodoState) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is ResponseTodoState) {
          final todos = state.todos;
          return ListView.builder(
            itemBuilder: (context, index) {
              final todo = todos[index];
              return Card(
                elevation: 3,
                margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: ListTile(
                  contentPadding: EdgeInsets.symmetric(horizontal: 10),
                  title: Text(
                    '${todo.id} :  ${todo.title}',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text(
                    'User: ${todo.userId}',
                    textAlign: TextAlign.end,
                  ),
                  leading: Checkbox(
                    value: todo.completed,
                    onChanged: (value) {
                      // Checkbox durumu değiştiğinde yapılacak işlemleri burada belirtebilirsiniz.
                    },
                  ),
                ),
              );
            },
          );
        } else if (state is ErrorTodoState) {
          return Center(child: Text(state.message));
        }

        return Center(
          child: Text(state.toString()),
        );
      }),
    );
  }
}
