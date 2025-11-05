import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../localization/app_localizations.dart';

typedef void IntCallback(int value);

class ProgressScreen extends StatefulWidget {
  @override
  _ProgressScreenState createState() => _ProgressScreenState();
}

class _ProgressScreenState extends State<ProgressScreen> {
  int _currentStreak = 0;
  int _bestStreak = 0;

  @override
  void initState() {
    super.initState();
    _loadStats();
  }

  Future<void> _loadStats() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _currentStreak = prefs.getInt('currentStreak') ?? 0;
      _bestStreak = prefs.getInt('bestStreak') ?? 0;
    });
  }

  Future<void> _resetStreak() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('currentStreak', 0);
    setState(() {
      _currentStreak = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context);
    return Scaffold(
      appBar: AppBar(title: Text(loc.translate('progress'))),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('${loc.translate('streak')}: $_currentStreak', style: TextStyle(fontSize: 20)),
            SizedBox(height: 10),
            Text('${loc.translate('best_streak')}: $_bestStreak', style: TextStyle(fontSize: 20)),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _resetStreak,
              child: Text(loc.translate('reset_streak')),
            )
          ],
        ),
      ),
    );
  }
}