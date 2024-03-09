import 'package:danshga_yar/pages/HomePage.dart';
import 'package:flutter/material.dart';
import 'package:danshga_yar/Tasks.dart';
import 'package:danshga_yar/pages/barbutton.dart';
import 'package:hive/hive.dart';

class EditTeskScreen extends StatefulWidget {
  EditTeskScreen({super.key, required this.task});
  Tasks task;
  @override
  State<EditTeskScreen> createState() => _EditTeskScreenState();
}

class _EditTeskScreenState extends State<EditTeskScreen> {
  final box1 = Hive.box<Tasks>('TasksBox');

  TextEditingController? ControllerTaskTitle;
  TextEditingController? ControllerTaskSubTitle;
  FocusNode negahban1 = FocusNode();
  FocusNode negahban2 = FocusNode();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    ControllerTaskTitle = TextEditingController(text: widget.task.Title);
    ControllerTaskSubTitle = TextEditingController(text: widget.task.SubTitle);

    negahban1.addListener(() {
      setState(() {});
    });

    negahban2.addListener(() {
      setState(() {});
    });
  }

  Widget build(BuildContext context) {
    String inputText = '';
    bool isNumeric = false;
    return Scaffold(
        body: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Expanded(child: const SizedBox()),
        Container(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 34),
            child: Directionality(
              textDirection: TextDirection.rtl,
              child: TextField(
                controller: ControllerTaskTitle,
                onChanged: (text) {
                  setState(() {
                    inputText = text;
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

                  // suffixIcon: isNumeric
                  //     ? Icon(Icons.clear, color: Colors.red)
                  //     : Icon(Icons.check, color: Colors.green),
                  border: const OutlineInputBorder(
                    borderRadius: const BorderRadius.all(Radius.circular(15)),
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
                  errorBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.red, width: 2.0),
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  focusedErrorBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.red, width: 2.0),
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                ),
                style: const TextStyle(fontSize: 16.0, color: Colors.black),
              ),
            ),
          ),
        ),
        const SizedBox(height: 56.0),
        //textfilde 2
        Container(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 34),
            child: Directionality(
              textDirection: TextDirection.rtl,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Textfilde 2.............................................................
                  TextField(
                    controller: ControllerTaskSubTitle,
                    onChanged: (text) {
                      setState(() {
                        inputText = text;
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

                      // suffixIcon: isNumeric
                      //     ? Icon(Icons.clear, color: Colors.red)
                      //     : Icon(Icons.check, color: Colors.green),
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
                      errorBorder: OutlineInputBorder(
                        borderSide:
                            const BorderSide(color: Colors.red, width: 2.0),
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      focusedErrorBorder: OutlineInputBorder(
                        borderSide:
                            const BorderSide(color: Colors.red, width: 2.0),
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                    ),
                    style: const TextStyle(fontSize: 16.0, color: Colors.black),
                  ),
                  const SizedBox(height: 5.0),
                  ElevatedButton(
                      onPressed: () {
                        String taskTitle = ControllerTaskTitle!.text;
                        String subTitle = ControllerTaskSubTitle!.text;
                        EditTask(taskTitle, subTitle);
                      },
                      child: const Text(
                        'ویرایش تسک',
                        style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xff18DAA3),
                        minimumSize: const Size(200, 48),
                      )),
                  SizedBox(
                    height: 20,
                  )
                ],
              ),
            ),
          ),
        ),
      ],
    ));
  }

  EditTask(String taskTitle, String subTitle) {
    widget.task.Title = taskTitle;
    widget.task.SubTitle = subTitle;
    widget.task.isDone = false;
    widget.task.save();
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (_) => const HomePage()));
  }
}
