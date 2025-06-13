class Task {
  String title;
  String description;
  DateTime dueDate;
  DateTime? createdAt;
  bool isCompleted;

  Task({
    required this.title,
    required this.description,
    required this.dueDate,
    required this.createdAt,
    this.isCompleted = false,
  });

  Map<String, dynamic> toJson() => {
        'title': title,
        'description': description,
        'dueDate': dueDate.toIso8601String(),
        'createdAt': createdAt?.toIso8601String(),
        'isCompleted': isCompleted,
      };

  static Task fromJson(Map<String, dynamic> json) => Task(
        title: json['title'],
        description: json['description'],
        dueDate: DateTime.parse(json['dueDate']),
        createdAt: DateTime.parse(json['createdAt']),
        isCompleted: json['isCompleted'],
      );
}
