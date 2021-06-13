import 'package:flutter/material.dart';

import '../models/task.dart';

import 'package:hive/hive.dart';

class Tasks with ChangeNotifier {
  List<Task> _tasks = [];

  List<Task> get tasks => [..._tasks];

  final _tasksBox = Hive.box<Task>('tasks');

  Future getTasks() async {
    _tasks.clear();
    _tasksBox.values.forEach((element) {
      final _task = Task(
        title: element.title,
        isCompleted: element.isCompleted,
      );
      _tasks.add(_task);
    });

    notifyListeners();
  }

  Future addTask({required String? title}) async {
    final Task _task = Task(title: title);
    await _tasksBox.add(_task);
    await getTasks();
  }

  Future updateTask({required String? title, required int index}) async {
    final _isCompleted = !_tasks[index].isCompleted!;
    final Task _task = Task(title: title, isCompleted: _isCompleted);
    await _tasksBox.putAt(index, _task);
    await getTasks();
  }

  Future deleteTask({required int index}) async {
    await _tasksBox.deleteAt(index);
    await getTasks();
  }
}
