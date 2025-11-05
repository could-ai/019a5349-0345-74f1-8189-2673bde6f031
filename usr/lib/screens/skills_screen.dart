import 'package:flutter/material.dart';
import '../models/skill.dart';
import '../localization/app_localizations.dart';

class SkillsScreen extends StatelessWidget {
  final List<Skill> skills = [
    Skill(
        title: 'Discipline',
        descriptionEn: 'Practice daily routines and stay committed.',
        descriptionHi: 'दैनिक दिनचर्या का अभ्यास करें और प्रतिबद्ध रहें।'),
    Skill(
        title: 'Focus',
        descriptionEn: 'Eliminate distractions and train your mind.',
        descriptionHi: 'विक्षेपों को समाप्त करें और अपने मन को प्रशिक्षित करें।'),
    Skill(
        title: 'Confidence',
        descriptionEn: 'Challenge yourself and celebrate small wins.',
        descriptionHi: 'खुद को चुनौती दें और छोटी सफलताओं का जश्न मनाएं।'),
    Skill(
        title: 'Communication',
        descriptionEn: 'Practice active listening and clear expression.',
        descriptionHi: 'सक्रिय सुनने और स्पष्ट अभिव्यक्ति का अभ्यास करें।'),
    // Add more skills as needed
  ];

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context);
    final lang = Localizations.localeOf(context).languageCode;
    return Scaffold(
      appBar: AppBar(title: Text(loc.translate('skills'))),
      body: ListView.builder(
        itemCount: skills.length,
        itemBuilder: (context, index) {
          final skill = skills[index];
          return ListTile(
            title: Text(skill.title),
            subtitle: Text(lang == 'hi' ? skill.descriptionHi : skill.descriptionEn),
          );
        },
      ),
    );
  }
}