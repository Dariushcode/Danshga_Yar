import 'package:hive_flutter/hive_flutter.dart';

part 'Tasks.g.dart';

@HiveType(typeId: 3)
class Tasks {
  Tasks({required this.Title, required this.SubTitle});
  @HiveField(0)
  String Title;
  @HiveField(1)
  String SubTitle;
}
