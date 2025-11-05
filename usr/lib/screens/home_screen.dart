import 'package:flutter/material.dart';
import '../localization/app_localizations.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context);
    return Scaffold(
      appBar: AppBar(title: Text(loc.translate('home'))),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                loc.translate('greeting'),
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 20),
              Text(
                loc.translate('daily_task') + ':',
                style: TextStyle(fontSize: 18),
              ),
              // Future: Show today's task summary or preview here
            ],
          ),
        ),
      ),
    );
  }
}