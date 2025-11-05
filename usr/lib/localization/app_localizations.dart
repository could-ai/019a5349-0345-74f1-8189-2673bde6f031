import 'dart:async';
import 'package:flutter/material.dart';

class AppLocalizations {
  final Locale locale;
  AppLocalizations(this.locale);

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  static const LocalizationsDelegate<AppLocalizations> delegate = _AppLocalizationsDelegate();

  static final Map<String, Map<String, String>> _localizedValues = {
    'en': {
      'app_title': 'NTN',
      'home': 'Home',
      'tasks': 'Tasks',
      'meditation': 'Meditation',
      'progress': 'Progress',
      'skills': 'Skills',
      'settings': 'Settings',
      'greeting': 'Keep improving yourself!',
      'language': 'Language',
      'export': 'Export Tasks',
      'import': 'Import Tasks',
      'daily_task': 'Daily Task',
      'mark_complete': 'Mark as Completed',
      'completed': 'Completed',
      'streak': 'Current Streak',
      'best_streak': 'Best Streak',
      'reset_streak': 'Reset Streak',
    },
    'hi': {
      'app_title': 'एनटीएन',
      'home': 'होम',
      'tasks': 'टास्क',
      'meditation': 'ध्यान',
      'progress': 'प्रगति',
      'skills': 'कौशल',
      'settings': 'सेटिंग्स',
      'greeting': 'खुद को सुधारते रहें!',
      'language': 'भाषा',
      'export': 'टास्क निर्यात करें',
      'import': 'टास्क आयात करें',
      'daily_task': 'दैनिक कार्य',
      'mark_complete': 'पूरा हुआ चिन्हित करें',
      'completed': 'पूरा हुआ',
      'streak': 'वर्तमान स्ट्रीक',
      'best_streak': 'सर्वश्रेष्ठ स्ट्रीक',
      'reset_streak': 'स्ट्रीक रीसेट करें',
    }
  };

  String translate(String key) {
    return _localizedValues[locale.languageCode]?[key] ?? key;
  }
}

class _AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) => ['en', 'hi'].contains(locale.languageCode);

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(AppLocalizations(locale));
  }

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}