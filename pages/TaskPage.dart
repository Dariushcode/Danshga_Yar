import 'package:danshga_yar/style/textthem.dart';
import 'package:danshga_yar/style/widget_task.dart';
import 'package:flutter/material.dart ';
import 'package:hive/hive.dart';

import 'EditText.dart';
import '../Tasks.dart';
import 'barbutton.dart';

class TaskPage extends StatefulWidget {
  TaskPage({super.key});

  @override
  State<TaskPage> createState() => _TaskPageState();
}

final box = Hive.box<Tasks>('TasksBox');

class _TaskPageState extends State<TaskPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  Widget build(BuildContext context) {
    var taskCount = 0;
    taskCount = box.values.length;
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 80,
        centerTitle: true,
        title: Directionality(
          textDirection: TextDirection.rtl,
          child: Text(
            '$taskCount تسک فعال در امروز  ',
            style: const TextStyle(fontSize: 25),
          ),
        ),
      ),
      bottomNavigationBar: BarButton(),
      body: Column(
        children: [
          const SizedBox(
            height: 20,
          ),
          const SingleChildScrollView(
            scrollDirection: Axis.horizontal,
          ),
          Expanded(
            child: ListView.separated(
              separatorBuilder: (context, index) => const SizedBox(
                  height: 16), // افزودن یک فاصله 16 پیکسل بین هر آیتم
              itemBuilder: (context, index) {
                var tasks = box.values.toList()[index];
                return GetTaskWidget(tasks);
              },
              itemCount: box.values.length,
            ),
          ),
        ],
      ),
    );
  }

  Widget GetTaskWidget(Tasks tasks) {
    return Dismissible(
      key: UniqueKey(),
      onDismissed: (direction) {
        if (direction == DismissDirection.startToEnd) {
          // به سمت چپ کشیده شده و حذف شده
          setState(() {
            tasks.delete();
          });
        } else if (direction == DismissDirection.endToStart) {
          // به سمت راست کشیده شده ویرایش شود

          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return EditTeskScreen(task: tasks);
          }));
        }
      },
      background: Container(
        decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(
              Radius.circular(30),
            ),
            color: Colors.redAccent),
        // رنگ پس زمینه حذف
        child: const Align(
          alignment: Alignment.centerLeft, // تنظیمات به سمت چپ
          child: Padding(
            padding: EdgeInsets.only(left: 16.0),
            child: Row(
              children: [
                Text(
                  'حذف',
                  style: TextStyle(fontSize: 19, color: Colors.white),
                ),
                Icon(
                  Icons.delete, // آیکون حذف
                  color: Colors.white,
                ),
              ],
            ),
          ),
        ),
      ),
      secondaryBackground: Container(
        decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(
              Radius.circular(30),
            ),
            color: Colors.greenAccent),
        child: const Align(
          alignment: Alignment.centerRight, // تنظیمات به سمت راست
          child: Padding(
            padding: EdgeInsets.only(right: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  'ویرایش',
                  style: TextStyle(fontSize: 19, color: Colors.white),
                ),
                Icon(
                  Icons.edit, // آیکون ویرایش
                  color: Colors.white,
                ),
              ],
            ),
          ),
        ),
      ),
      child: TaskWidget(task: tasks),
    );
  }
}
