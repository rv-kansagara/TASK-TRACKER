import 'package:flutter/material.dart';

import 'package:rive/rive.dart';

import 'package:provider/provider.dart';

import '../../data/providers/tasks.dart';

import 'task_tile.dart';

class AllTasks extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final tasks = Provider.of<Tasks>(context).tasks;
    return Container(
      child: tasks.length > 0
          ? ListView.builder(
              padding: const EdgeInsets.all(20),
              physics: const BouncingScrollPhysics(),
              itemCount: tasks.length,
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    TaskTile(index: index),
                    const SizedBox(height: 10),
                  ],
                );
              },
            )
          : Center(
              child: const SizedBox(
                height: 200,
                child: const RiveAnimation.asset(
                  'assets/rive/pencil.riv',
                  fit: BoxFit.contain,
                ),
              ),
            ),
    );
  }
}
