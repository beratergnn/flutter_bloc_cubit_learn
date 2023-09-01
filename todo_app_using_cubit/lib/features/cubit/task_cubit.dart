import 'package:cubit_learn/features/cubit/task_state.dart';
import 'package:cubit_learn/features/models/task_model.dart';
import 'package:cubit_learn/features/repository/task_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TaskCubit extends Cubit<TaskState> {
  final TaskRepository _repository;

  TaskCubit(this._repository) : super(TaskInitial());

  void loadTasks() async {
    emit(TaskLoading());
    await Future.delayed(Duration(milliseconds: 1800));
    final tasks = _repository.getTasks();
    emit(TaskLoaded(tasks));
  }

  void toggleTaskCompletion(Task task) {
    final updatedTask = task.copyWith(isCompleted: !task.isCompleted);
    final updatedTasks = (state as TaskLoaded)
        .tasks
        .map((t) => t.id == task.id ? updatedTask : t)
        .toList();
    _repository.saveTasks(updatedTasks);
    emit(TaskLoaded(updatedTasks));
  }

  void addTask(String title) {
    final newTask = Task(
        id: DateTime.now().millisecondsSinceEpoch.toString(), title: title);
    final updatedTasks = (state as TaskLoaded).tasks + [newTask];
    _repository.saveTasks(updatedTasks);
    emit(TaskLoaded(updatedTasks));
  }

  void deleteTask(Task task) {
    final updatedTasks =
        (state as TaskLoaded).tasks.where((t) => t.id != task.id).toList();
    _repository.saveTasks(updatedTasks);
    emit(TaskLoaded(updatedTasks));
  }
}
