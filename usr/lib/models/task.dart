class Task {
  final String id;
  final String description;
  final DateTime date;
  bool completed;

  Task({required this.id, required this.description, required this.date, this.completed = false});

  factory Task.fromMap(Map<String, dynamic> map) {
    return Task(
      id: map['id'],
      description: map['description'],
      date: DateTime.parse(map['date']),
      completed: map['completed'] == 1,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'description': description,
      'date': date.toIso8601String(),
      'completed': completed ? 1 : 0,
    };
  }
}