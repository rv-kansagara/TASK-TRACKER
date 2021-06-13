import 'dart:ui';

import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import '../constants/constants.dart';

import '../../data/providers/tasks.dart';

class CustomButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async => await buildCreateTaskBottomSheet(context),
      child: Container(
        height: 60,
        width: double.infinity,
        margin: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: const Color(0XFFFFC400),
          borderRadius: BorderRadius.circular(14),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.add_circle_outline,
              color: Colors.black,
              size: 24,
            ),
            const SizedBox(width: 10),
            const Text(
              'CREATE TASK',
              style: const TextStyle(
                color: Colors.black,
                fontSize: 16,
                letterSpacing: 1,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future buildCreateTaskBottomSheet(BuildContext context) {
    String? title;
    final tasks = Provider.of<Tasks>(context, listen: false);

    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return SingleChildScrollView(
          child: Container(
            decoration: BoxDecoration(
              color: Theme.of(context).brightness == Brightness.dark
                  ? kBottomSheetBackgroundColor
                  : Colors.grey[50],
              borderRadius: BorderRadius.circular(20),
            ),
            margin: const EdgeInsets.all(6),
            padding: EdgeInsets.only(
              top: 10,
              bottom: MediaQuery.of(context).viewInsets.bottom + 10,
            ),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: TextField(
                    autofocus: true,
                    textCapitalization: TextCapitalization.words,
                    decoration: InputDecoration(
                      labelText: 'Title',
                      hintText: 'eg. Buy a Chocolate',
                      suffixIcon: Icon(Icons.title_rounded),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(14),
                        gapPadding: 2,
                      ),
                    ),
                    onChanged: (input) => title = input,
                  ),
                ),
                GestureDetector(
                  onTap: () async {
                    await tasks
                        .addTask(title: title)
                        .then((_) => Navigator.pop(context));
                  },
                  child: Container(
                    height: 60,
                    width: double.infinity,
                    margin: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 10,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0XFFFFC400),
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.add_circle_outline,
                          color: Colors.black,
                          size: 24,
                        ),
                        const SizedBox(width: 10),
                        const Text(
                          'CREATE',
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            letterSpacing: 1,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
