import 'package:danshga_yar/Tasks.dart';
import 'package:danshga_yar/pages/barbutton.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:time_pickerr/time_pickerr.dart';
import 'HomePage.dart';

class AddTeskScreen extends StatefulWidget {
  const AddTeskScreen({super.key});

  @override
  State<AddTeskScreen> createState() => _AddTeskScreenState();
}

class _AddTeskScreenState extends State<AddTeskScreen> {
  final box1 = Hive.box<Tasks>('TasksBox');

  final TextEditingController ControllerTaskTitle = TextEditingController();
  final TextEditingController ControllerTaskSubTitle = TextEditingController();
  FocusNode negahban1 = FocusNode();
  FocusNode negahban2 = FocusNode();
  bool isTitleFilled = false;

  DateTime _time = DateTime.now();
  @override
  void initState() {
    super.initState();
    negahban1.addListener(() {
      setState(() {});
    });

    negahban2.addListener(() {
      setState(() {});
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BarButton(),
      body: CustomScrollView(
        slivers: [
          SliverPadding(
            padding: EdgeInsets.all(20),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 34),
              child: Directionality(
                textDirection: TextDirection.rtl,
                child: Container(
                  child: TextField(
                    controller: ControllerTaskTitle,
                    onChanged: (text) {
                      setState(() {
                        isTitleFilled = text
                            .trim()
                            .isNotEmpty; // تنظیم وضعیت بر اساس پر یا خالی بودن
                      });
                    },
                    cursorColor: Colors.greenAccent,
                    decoration: InputDecoration(
                      labelText: 'عنوان تسک',
                      labelStyle: TextStyle(
                        fontSize: 20,
                        color: negahban1.hasFocus
                            ? const Color(0xff18DAA3)
                            : const Color(0xffC5C5C5),
                      ),
                      hintText: 'یه چیزی بنویس !',
                      prefixIcon: const Icon(Icons.add_task_outlined,
                          color: Colors.greenAccent),
                      border: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(15)),
                        borderSide:
                            BorderSide(color: Color(0xffC5C5C5), width: 3.0),
                      ),
                      filled: true,
                      fillColor: Colors.greenAccent.withOpacity(0.1),
                      focusedBorder: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(15)),
                        borderSide: BorderSide(
                          width: 3,
                          color: Color(0xff18DAA3),
                        ),
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 16.0, horizontal: 20.0),
                    ),
                    style: const TextStyle(fontSize: 16.0, color: Colors.black),
                  ),
                ),
              ),
            ),
          ),
          SliverPadding(
            padding: EdgeInsets.all(20),
          ),
          SliverToBoxAdapter(
            child: Directionality(
              textDirection: TextDirection.rtl,
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 34),
                    child: TextField(
                      controller: ControllerTaskSubTitle,
                      onChanged: (text) {
                        setState(() {
                          // Handle changes
                        });
                      },
                      maxLines: 3,
                      cursorColor: Colors.greenAccent,
                      decoration: InputDecoration(
                        labelText: 'توضیحات تسک',
                        labelStyle: TextStyle(
                          fontSize: 20,
                          color: negahban1.hasFocus
                              ? const Color(0xff18DAA3)
                              : const Color(0xffC5C5C5),
                        ),
                        hintText: 'یه چیزی بنویس !',
                        prefixIcon: const Icon(Icons.add_task_outlined,
                            color: Colors.greenAccent),
                        border: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(15)),
                          borderSide:
                              BorderSide(color: Color(0xffC5C5C5), width: 3.0),
                        ),
                        filled: true,
                        fillColor: Colors.greenAccent.withOpacity(0.1),
                        focusedBorder: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(15)),
                          borderSide: BorderSide(
                            width: 3,
                            color: Color(0xff18DAA3),
                          ),
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 16.0, horizontal: 20.0),
                      ),
                      style:
                          const TextStyle(fontSize: 16.0, color: Colors.black),
                    ),
                  ),
                  CustomHourPicker(
                    date: _time,
                    elevation: 1.1,
                    title: 'زمان تسک رو انتخاب کن',
                    negativeButtonText: 'کنسل',
                    negativeButtonStyle: TextStyle(
                        fontSize: 15,
                        color: Colors.redAccent,
                        fontWeight: FontWeight.bold),
                    positiveButtonText: 'انتخاب زمان',
                    positiveButtonStyle: TextStyle(
                        fontSize: 15,
                        color: Colors.greenAccent,
                        fontWeight: FontWeight.bold),
                    onPositivePressed: (context, time) {
                      _time = time;
                    },
                    onNegativePressed: (context) {},
                  ),
                  Padding(
                    padding: const EdgeInsets.all(34.0),
                    child: ElevatedButton(
                      onPressed: () {
                        String taskTitle = ControllerTaskTitle.text;
                        String subTitle = ControllerTaskSubTitle.text;
                        // چک کردن خالی بودن textfield ها و وضعیت عنوان
                        if (taskTitle.trim().isEmpty || !isTitleFilled) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              duration: Duration(milliseconds: 800),
                              content: Text(
                                'لطفاً  عنوان تسک را وارد کنید',
                                textAlign: TextAlign.right,
                                style: TextStyle(),
                              ),
                              backgroundColor: Colors.red,
                            ),
                          );
                        } else {
                          // اضافه کردن تسک
                          addTask(taskTitle, subTitle);
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xff18DAA3),
                        minimumSize: const Size(200, 48),
                      ),
                      child: const Text(
                        'اضافه کردن تسک',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  addTask(String taskTitle, String subTitle) {
    var task = Tasks(Title: taskTitle, SubTitle: subTitle, time: _time);
    box1.add(task);
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (_) => const HomePage()));
  }
}
