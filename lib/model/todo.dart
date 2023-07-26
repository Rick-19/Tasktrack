import 'package:hive/hive.dart';
part 'todo.g.dart';

@HiveType(typeId: 0)
class Todo {
  @HiveField(0)
  final String title;
  @HiveField(1)
  final DateTime date;
  @HiveField(2)
  bool? ischecked;
  @HiveField(3)
  final String id;
  Todo(
      {required this.date,
      required this.title,
      required this.ischecked,
      required this.id});
}
