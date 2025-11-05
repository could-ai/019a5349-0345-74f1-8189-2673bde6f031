import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/task.dart';

class TaskService extends ChangeNotifier {
  List<Task> _tasks = [];
  DateTime _today = DateTime.now();

  List<Task> get tasksForToday {
    return _tasks.where((t) => isSameDate(t.date, _today)).toList();
  }

  TaskService() {
    _loadTasks();
    _generateDefaultTasks();
  }

  bool isSameDate(DateTime a, DateTime b) {
    return a.year == b.year && a.month == b.month && a.day == b.day;
  }

  Future<void> _loadTasks() async {
    final prefs = await SharedPreferences.getInstance();
    final data = prefs.getString('tasks');
    if (data != null) {
      final list = jsonDecode(data) as List;
      _tasks = list.map((e) => Task.fromMap(e)).toList();
    }
    notifyListeners();
  }

  Future<void> _saveTasks() async {
    final prefs = await SharedPreferences.getInstance();
    final data = jsonEncode(_tasks.map((t) => t.toMap()).toList());
    await prefs.setString('tasks', data);
  }

  void _generateDefaultTasks() {
    // If no tasks for today, generate one task per weekday Monday-Saturday
    for (int i = 1; i <= 6; i++) {
      final date = DateTime(_today.year, _today.month, _today.day + (i - _today.weekday));
      if (!_tasks.any((t) => isSameDate(t.date, date))) {
        _tasks.add(Task(
            id: date.toIso8601String(),
            description: 'Task for ${_weekdayName(date.weekday)}',
            date: date));
      }
    }
    _saveTasks();
  }

  String _weekdayName(int weekday) {
    const names = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
    return names[weekday - 1];
  }

  void toggleCompletion(Task task) {
    task.completed = !task.completed;
    _saveTasks();
    notifyListeners();
  }

  // TODO: Add methods for syncing with Google Sheets
}