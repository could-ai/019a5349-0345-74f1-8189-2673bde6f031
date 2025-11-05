import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/task.dart';
import '../services/task_service.dart';
import '../localization/app_localizations.dart';

class TasksScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context);
    return Scaffold(
      appBar: AppBar(title: Text(loc.translate('tasks'))),
      body: Consumer<TaskService>(
        builder: (context, service, child) {
          final tasks = service.tasksForToday;
          if (tasks.isEmpty) {
            return Center(child: Text('No tasks found for today'));
          }
          return ListView.builder(
            itemCount: tasks.length,
            itemBuilder: (context, index) {
              final Task task = tasks[index];
              return ListTile(
                title: Text(task.description),
                trailing: IconButton(
                  icon: Icon(
                    task.completed ? Icons.check_circle : Icons.radio_button_unchecked,
                    color: task.completed ? Colors.green : null,
                  ),
                  onPressed: () {
                    service.toggleCompletion(task);
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}