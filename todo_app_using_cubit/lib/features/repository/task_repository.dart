import 'package:cubit_learn/features/models/task_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TaskRepository {
  final SharedPreferences _prefs;

  TaskRepository(this._prefs);

  List<Task> getTasks() {
    final tasks = _prefs.getStringList('tasks') ?? [];
    return tasks.map((taskStr) {
      final taskData = taskStr.split(',');
      return Task(
          id: taskData[0],
          title: taskData[1],
          isCompleted: taskData[2] == 'true');
    }).toList();
  }

  void saveTasks(List<Task> tasks) {
    final taskStrList = tasks
        .map((task) => '${task.id},${task.title},${task.isCompleted}')
        .toList();
    _prefs.setStringList('tasks', taskStrList);
  }
}
