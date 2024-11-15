class Task {
  String title;
  String description;
  DateTime createdAt;
  bool isCompleted;

  Task({
    required this.title,
    required this.description,
    DateTime? createdAt,
    this.isCompleted = false,
  }) : createdAt = createdAt ?? DateTime.now();
}
