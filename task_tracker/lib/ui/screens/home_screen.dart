import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import '../../data/providers/tasks.dart';

import '../widgets/all_tasks.dart';
import '../widgets/custom_button.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<Tasks>(
      builder: (context, data, _) {
        return Scaffold(
          floatingActionButton: CustomButton(),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,
          appBar: AppBar(
            title: const Text(
              'TASK TRACKER',
              style: const TextStyle(letterSpacing: 2),
            ),
          ),
          body: AllTasks(),
        );
      },
    );
  }
}
