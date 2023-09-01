import 'package:cubit_learn/features/cubit/task_cubit.dart';
import 'package:cubit_learn/features/cubit/task_state.dart';
import 'package:cubit_learn/features/models/task_model.dart';
import 'package:cubit_learn/features/repository/task_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TaskPage extends StatelessWidget {
  final SharedPreferences prefs;

  TaskPage({required this.prefs});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(
        'Task Manager',
        style: TextStyle(
          color: Colors.grey.shade600,
          fontWeight: FontWeight.bold,
          fontSize: 25,
        ),
      )),
      body: BlocProvider(
        create: (context) => TaskCubit(
          TaskRepository(prefs),
        ), // SharedPreferences argümanını TaskRepository'ye geçir
        child: TaskListView(),
      ),
    );
  }
}

class TaskListView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final cubit = context.read<TaskCubit>();
    cubit.loadTasks();

    return BlocBuilder<TaskCubit, TaskState>(
      builder: (context, state) {
        if (state is TaskLoading) {
          return Center(
            child: SpinKitThreeInOut(
              color: Colors.grey.shade400,
            ),
          );
        } else if (state is TaskLoaded) {
          return Column(
            children: [
              const SizedBox(height: 10),
              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  itemCount: state.tasks.length,
                  itemBuilder: (context, index) {
                    final task = state.tasks[index];
                    return Column(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.grey.shade300,
                            borderRadius: const BorderRadius.only(
                              topRight: Radius.circular(20),
                              bottomLeft: Radius.circular(20),
                              bottomRight: Radius.circular(20),
                            ),
                          ),
                          child: TaskTile(task: task),
                        ),
                        const SizedBox(height: 10)
                      ],
                    );
                  },
                ),
              ),
              addTaskButton(context, cubit),
            ],
          );
        } else {
          return const Center(child: Text('An error occurred.'));
        }
      },
    );
  }

  // * Add Task Button Design
  Container addTaskButton(BuildContext context, TaskCubit cubit) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey.shade500,
        borderRadius: const BorderRadius.vertical(
          top: Radius.circular(20),
        ),
      ),
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
      child: InkWell(
        onTap: () {
          _showAddTaskDialog(
              context, cubit); // Yeni task eklemek için dialog göster
        },
        child: const Text(
          'Add Task',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 25,
          ),
        ),
      ),
    );
  }

  // * Add Task Button Clicked
  void _showAddTaskDialog(BuildContext context, TaskCubit cubit) {
    showDialog(
      context: context,
      builder: (context) {
        String newTaskTitle = ''; // Yeni task başlığı
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.0),
          ),
          child: Container(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Text(
                  'Add New Task',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20.0,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 16.0),
                TextField(
                  onChanged: (value) {
                    newTaskTitle = value;
                  },
                  decoration: const InputDecoration(
                    hintText: 'Write your task here!',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 16.0),
                ElevatedButton(
                  onPressed: () {
                    if (newTaskTitle.isNotEmpty) {
                      cubit.addTask(newTaskTitle);
                      Navigator.of(context).pop();
                    }
                  },
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.grey.shade600,
                      minimumSize: Size(double.infinity, 45.0)),
                  child: const Text(
                    'Add',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

// * Task List Design
class TaskTile extends StatelessWidget {
  final Task task;

  TaskTile({required this.task});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<TaskCubit>();

    return ListTile(
      title: Text(
        task.title,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 20,
          decoration: task.isCompleted
              ? TextDecoration.lineThrough
              : TextDecoration.none,
        ),
      ),
      leading: Transform.scale(
        scale: 1.8,
        child: Checkbox(
          checkColor: Colors.white,
          fillColor: MaterialStateProperty.resolveWith<Color>(
            (Set<MaterialState> states) {
              if (states.contains(MaterialState.selected)) {
                return Colors.green;
              }
              return Colors.red;
            },
          ),
          value: task.isCompleted,
          shape: const CircleBorder(),
          onChanged: (_) => cubit.toggleTaskCompletion(task),
        ),
      ),
      trailing: IconButton(
        icon: const Icon(
          Icons.delete_outlined,
          size: 35,
        ),
        onPressed: () => cubit.deleteTask(task),
      ),
      subtitle: Align(
        alignment: Alignment.bottomLeft,
        child: Text(
          task.isCompleted ? 'Completed' : 'In Progress',
          style: TextStyle(
            color: task.isCompleted ? Colors.green : Colors.red,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
