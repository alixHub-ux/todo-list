// lib/models/task_model.dart

class Task {
  int? id;
  String name;
  DateTime date;
  bool isCompleted;
  int? userId;
  DateTime createdAt;

  Task({
    this.id,
    required this.name,
    required this.date,
    this.isCompleted = false,
    this.userId,
    required this.createdAt,
  });

  // Convert Task to Map for database storage
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'date': date.toIso8601String(),
      'is_completed': isCompleted ? 1 : 0,
      'user_id': userId,
      'created_at': createdAt.toIso8601String(),
    };
  }

  // Create Task object from Map fetched from database
  factory Task.fromMap(Map<String, dynamic> map) {
    return Task(
      id: map['id'],
      name: map['name'],
      date: DateTime.parse(map['date']),
      isCompleted: map['is_completed'] == 1,
      userId: map['user_id'],
      createdAt: DateTime.parse(map['created_at']),
    );
  }

  // Copy with updates (useful for modifying a task)
  Task copyWith({
    int? id,
    String? name,
    DateTime? date,
    bool? isCompleted,
    int? userId,
    DateTime? createdAt,
  }) {
    return Task(
      id: id ?? this.id,
      name: name ?? this.name,
      date: date ?? this.date,
      isCompleted: isCompleted ?? this.isCompleted,
      userId: userId ?? this.userId,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  String toString() {
    return 'Task{id: $id, name: $name, date: $date, isCompleted: $isCompleted, userId: $userId, createdAt: $createdAt}';
  }
}
