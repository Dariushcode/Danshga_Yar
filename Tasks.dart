import 'package:hive_flutter/hive_flutter.dart';

part 'Tasks.g.dart';

@HiveType(typeId: 3)
class Tasks extends HiveObject {
  Tasks(
      {required this.Title,
      required this.SubTitle,
      this.isDone = false,
      required this.time});
  @HiveField(0)
  String Title;
  @HiveField(1)
  String SubTitle;
  @HiveField(2)
  bool isDone;
  @HiveField(3)
  DateTime time;
}
