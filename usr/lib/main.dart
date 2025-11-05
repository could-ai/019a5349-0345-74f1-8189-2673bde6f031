import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'localization/app_localizations.dart';
import 'services/task_service.dart';
import 'services/notification_service.dart';
import 'screens/home_screen.dart';
import 'screens/tasks_screen.dart';
import 'screens/meditation_screen.dart';
import 'screens/progress_screen.dart';
import 'screens/skills_screen.dart';
import 'screens/settings_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await NotificationService().init();
  runApp(MultiProvider(
    providers: [ChangeNotifierProvider(create: (_) => TaskService())],
    child: MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();

  static void setLocale(BuildContext context, Locale newLocale) {
    _MyAppState? state = context.findAncestorStateOfType<_MyAppState>();
    state?.setLocale(newLocale);
  }
}

class _MyAppState extends State<MyApp> {
  Locale _locale = Locale('en');

  void setLocale(Locale locale) {
    setState(() {
      _locale = locale;
    });
  }

  int _currentIndex = 0;

  final List<Widget> _screens = [
    HomeScreen(),
    TasksScreen(),
    MeditationScreen(),
    ProgressScreen(),
    SkillsScreen(),
    SettingsScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'NTN',
      debugShowCheckedModeBanner: false,
      locale: _locale,
      supportedLocales: [Locale('en'), Locale('hi')],
      localizationsDelegates: [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      home: Scaffold(
        body: _screens[_currentIndex],
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: (index) => setState(() {
            _currentIndex = index;
          }),
          items: [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: AppLocalizations.of(context).translate('home')),
            BottomNavigationBarItem(icon: Icon(Icons.task), label: AppLocalizations.of(context).translate('tasks')),
            BottomNavigationBarItem(icon: Icon(Icons.self_improvement), label: AppLocalizations.of(context).translate('meditation')),
            BottomNavigationBarItem(icon: Icon(Icons.show_chart), label: AppLocalizations.of(context).translate('progress')),
            BottomNavigationBarItem(icon: Icon(Icons.star), label: AppLocalizations.of(context).translate('skills')),
            BottomNavigationBarItem(icon: Icon(Icons.settings), label: AppLocalizations.of(context).translate('settings')),
          ],
        ),
      ),
    );
  }
}