// lib/models/task_model.dart


class Task {
  int? id;              
  String name;          
  DateTime? dueDate;    
  bool isCompleted;     
  int? userId;          

  Task({
    this.id,
    required this.name,
    this.dueDate,
    this.isCompleted = false,
    this.userId,
  });

  // Convert Task to Map for database storage
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'due_date': dueDate?.toIso8601String(),
      'is_completed': isCompleted ? 1 : 0,
      'user_id': userId,
    };
  }

  // Create Task object from Map fetched from database
  factory Task.fromMap(Map<String, dynamic> map) {
    return Task(
      id: map['id'],
      name: map['name'],
      dueDate:
          map['due_date'] != null ? DateTime.parse(map['due_date']) : null,
      isCompleted: map['is_completed'] == 1,
      userId: map['user_id'],
    );
  }

  // Copy with updates (useful for modifying a task)
  Task copyWith({
    int? id,
    String? name,
    DateTime? dueDate,
    bool? isCompleted,
    int? userId,
  }) {
    return Task(
      id: id ?? this.id,
      name: name ?? this.name,
      dueDate: dueDate ?? this.dueDate,
      isCompleted: isCompleted ?? this.isCompleted,
      userId: userId ?? this.userId,
    );
  }

  @override
  String toString() {
    return 'Task{id: $id, name: $name, dueDate: ${formatDate(dueDate)}, isCompleted: $isCompleted, userId: $userId}';
  }
  
  formatDate(DateTime? dueDate) {}
}
