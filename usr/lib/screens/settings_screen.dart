import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';
import '../localization/app_localizations.dart';
import '../services/task_service.dart';
import '../services/sync_service.dart';

class SettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context);
    final taskService = Provider.of<TaskService>(context, listen: false);
    final syncService = SyncService();
    return Scaffold(
      appBar: AppBar(title: Text(loc.translate('settings'))),
      body: ListView(
        children: [
          ListTile(
            title: Text(loc.translate('language')),
            trailing: DropdownButton<String>(
              value: Localizations.localeOf(context).languageCode,
              items: [DropdownMenuItem(value: 'en', child: Text('English')), DropdownMenuItem(value: 'hi', child: Text('Hindi'))],
              onChanged: (lang) {
                if (lang != null) {
                  MyApp.setLocale(context, Locale(lang));
                }
              },
            ),
          ),
          ListTile(
            title: Text(loc.translate('export')),
            onTap: () async {
              final tasks = taskService.tasksForToday.map((t) => t.toMap()).toList();
              final csv = ListToCsvConverter().convert(tasks.map((e) => [e['id'], e['description'], e['date'], e['completed']]));
              final file = await Share.share(csv, subject: 'Tasks Export');
            },
          ),
          ListTile(
            title: Text(loc.translate('import')),
            onTap: () {
              // TODO: Implement CSV import via file_picker
            },
          ),
          ListTile(
            title: Text('Sync with Google Sheets'),
            onTap: () async {
              final success = await syncService.pushTasks(taskService.tasksForToday.map((t) => t.toMap()).toList());
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(success ? 'Sync successful' : 'Sync failed')));
            },
          ),
          ListTile(
            title: Text('Share Completed Tasks'),
            onTap: () {
              final completed = taskService.tasksForToday.where((t) => t.completed).map((t) => t.description).join('\n');
              if (completed.isEmpty) {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('No completed tasks')));
              } else {
                Share.share(completed, subject: 'Today\'s Completed Tasks');
              }
            },
          ),
        ],
      ),
    );
  }
}
