import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import '../../data/providers/tasks.dart';

class TaskTile extends StatefulWidget {
  final int index;

  TaskTile({required this.index});

  @override
  _TaskTileState createState() => _TaskTileState();
}

class _TaskTileState extends State<TaskTile> with TickerProviderStateMixin {
  late AnimationController _controller = AnimationController(
    vsync: this,
    duration: Duration(seconds: 1),
  )..forward();
  late Animation<double> _animation = CurvedAnimation(
    parent: _controller,
    curve: Curves.easeIn,
  );

  @override
  Widget build(BuildContext context) {
    return Consumer<Tasks>(
      builder: (context, data, _) {
        return Dismissible(
          key: UniqueKey(),
          direction: DismissDirection.endToStart,
          onDismissed: (direction) => data.deleteTask(index: widget.index),
          background: Container(
            padding: const EdgeInsets.all(20),
            alignment: Alignment.centerRight,
            child: const Icon(
              Icons.delete_forever_outlined,
              size: 30,
              color: Colors.deepOrange,
            ),
          ),
          child: FadeTransition(
            opacity: _animation,
            child: ListTile(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14),
              ),
              tileColor: Theme.of(context).brightness == Brightness.dark
                  ? const Color(0XFF101010)
                  : Colors.grey[200],
              leading: Image.asset('assets/icons/task.png', height: 60),
              title: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                child: Text(
                  data.tasks[widget.index].title!,
                  style: TextStyle(
                    fontSize: 18,
                    letterSpacing: 0.8,
                    decoration: data.tasks[widget.index].isCompleted!
                        ? TextDecoration.lineThrough
                        : TextDecoration.none,
                  ),
                ),
              ),
              subtitle: Padding(
                padding: const EdgeInsets.all(4),
                child: Text(
                  data.tasks[widget.index].isCompleted!
                      ? 'Completed'
                      : 'Pending',
                  style: const TextStyle(
                    fontSize: 15.5,
                    letterSpacing: 0.8,
                  ),
                ),
              ),
              trailing: Checkbox(
                value: data.tasks[widget.index].isCompleted,
                activeColor: const Color(0XFFFFC400),
                checkColor: Colors.black,
                onChanged: (value) async {
                  await data.updateTask(
                    title: data.tasks[widget.index].title,
                    index: widget.index,
                  );
                },
              ),
            ),
          ),
        );
      },
    );
  }
}
