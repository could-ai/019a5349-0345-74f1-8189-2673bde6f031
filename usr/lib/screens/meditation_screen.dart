import 'dart:async';
import 'package:flutter/material.dart';
import '../localization/app_localizations.dart';

class MeditationScreen extends StatefulWidget {
  @override
  _MeditationScreenState createState() => _MeditationScreenState();
}

class _MeditationScreenState extends State<MeditationScreen> {
  int _remainingSeconds = 0;
  Timer? _timer;

  void _startTimer(int seconds) {
    setState(() {
      _remainingSeconds = seconds;
    });
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (_remainingSeconds == 0) {
        timer.cancel();
      } else {
        setState(() {
          _remainingSeconds--;
        });
      }
    });
  }

  void _stopTimer() {
    _timer?.cancel();
    setState(() {
      _remainingSeconds = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context);
    return Scaffold(
      appBar: AppBar(title: Text(loc.translate('meditation'))),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            if (_remainingSeconds > 0)
              Text('${_remainingSeconds}s left', style: TextStyle(fontSize: 32)),
            SizedBox(height: 20),
            Wrap(
              spacing: 8,
              children: [
                ElevatedButton(
                  onPressed: () => _startTimer(60),
                  child: Text('1 min'),
                ),
                ElevatedButton(
                  onPressed: () => _startTimer(300),
                  child: Text('5 min'),
                ),
                ElevatedButton(
                  onPressed: () => _startTimer(600),
                  child: Text('10 min'),
                ),
                ElevatedButton(
                  onPressed: _stopTimer,
                  child: Text('Stop'),
                ),
              ],
            ),
            SizedBox(height: 20),
            Text(
              'Meditation helps reduce stress, improve focus, and enhance well-being.',
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}