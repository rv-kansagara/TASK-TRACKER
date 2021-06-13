import 'package:hive/hive.dart';

part 'task.g.dart';

@HiveType(typeId: 0)
class Task {
  @HiveField(0)
  final String? title;

  @HiveField(1)
  final bool? isCompleted;

  Task({required this.title, this.isCompleted = false});
}
