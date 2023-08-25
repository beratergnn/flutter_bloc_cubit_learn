class TodoModel {
  final int id;
  final int userId;
  final String title;
  final bool completed;

  TodoModel(
      {required this.id,
      required this.userId,
      required this.title,
      required this.completed});
}
