import 'package:flutter/material.dart';

import 'package:path_provider/path_provider.dart' as path_provider;

import 'package:provider/provider.dart';

import 'package:hive/hive.dart';

import 'data/models/task.dart';

import 'data/providers/tasks.dart';

import 'ui/theme/theme.dart';

import 'ui/screens/home_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final directory = await path_provider.getApplicationDocumentsDirectory();
  Hive.init('${directory.path}/hive');
  Hive.registerAdapter(TaskAdapter());
  await Hive.boxExists('tasks').then((_) => Hive.openBox<Task>('tasks'));
  runApp(App());
}

class App extends StatefulWidget {
  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  Widget build(BuildContext context) {
    final _tasks = Tasks();
    return ChangeNotifierProvider<Tasks>(
      create: (context) => _tasks,
      builder: (context, _) {
        return MaterialApp(
          title: 'Task Tracker',
          theme: lightTheme,
          darkTheme: darkTheme,
          home: FutureBuilder(
            future: _tasks.getTasks(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Scaffold(
                  body: Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              } else if (snapshot.connectionState == ConnectionState.done) {
                return snapshot.hasError
                    ? Scaffold(
                        body: Center(
                          child: CircularProgressIndicator(),
                        ),
                      )
                    : HomeScreen();
              } else {
                return HomeScreen();
              }
            },
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    Hive.close();
    super.dispose();
  }
}
