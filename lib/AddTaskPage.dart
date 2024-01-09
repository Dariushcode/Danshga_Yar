import 'package:danshga_yar/Tasks.dart';
import 'package:danshga_yar/barbutton.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

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
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
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
        bottomNavigationBar: BarButton(),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              height: 200,
            ),
            Container(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 34),
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
                            ? Color(0xff18DAA3)
                            : Color(0xffC5C5C5),
                      ),
                      hintText: 'یه چیزی بنویس !',
                      prefixIcon: Icon(Icons.add_task_outlined,
                          color: Colors.greenAccent),

                      // suffixIcon: isNumeric
                      //     ? Icon(Icons.clear, color: Colors.red)
                      //     : Icon(Icons.check, color: Colors.green),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(15)),
                        borderSide:
                            BorderSide(color: Color(0xffC5C5C5), width: 3.0),
                      ),
                      filled: true,
                      fillColor: Colors.greenAccent.withOpacity(0.1),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(15)),
                        borderSide: BorderSide(
                          width: 3,
                          color: Color(0xff18DAA3),
                        ),
                      ),
                      contentPadding: EdgeInsets.symmetric(
                          vertical: 16.0, horizontal: 20.0),
                      errorBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.red, width: 2.0),
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      focusedErrorBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.red, width: 2.0),
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                    ),
                    style: TextStyle(fontSize: 16.0, color: Colors.black),
                  ),
                ),
              ),
            ),
            SizedBox(height: 56.0),
            //textfilde 2
            Container(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 34),
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
                          labelText: 'عنوان تسک',
                          labelStyle: TextStyle(
                            fontSize: 20,
                            color: negahban1.hasFocus
                                ? Color(0xff18DAA3)
                                : Color(0xffC5C5C5),
                          ),
                          hintText: 'یه چیزی بنویس !',
                          prefixIcon: Icon(Icons.add_task_outlined,
                              color: Colors.greenAccent),

                          // suffixIcon: isNumeric
                          //     ? Icon(Icons.clear, color: Colors.red)
                          //     : Icon(Icons.check, color: Colors.green),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(15)),
                            borderSide: BorderSide(
                                color: Color(0xffC5C5C5), width: 3.0),
                          ),
                          filled: true,
                          fillColor: Colors.greenAccent.withOpacity(0.1),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(15)),
                            borderSide: BorderSide(
                              width: 3,
                              color: Color(0xff18DAA3),
                            ),
                          ),
                          contentPadding: EdgeInsets.symmetric(
                              vertical: 16.0, horizontal: 20.0),
                          errorBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.red, width: 2.0),
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          focusedErrorBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.red, width: 2.0),
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                        ),
                        style: TextStyle(fontSize: 16.0, color: Colors.black),
                      ),
                      SizedBox(height: 56.0),
                      ElevatedButton(
                          onPressed: () {
                            String taskTitle = ControllerTaskTitle.text;
                            String subTitle = ControllerTaskSubTitle.text;
                            addTask(taskTitle, subTitle);
                          },
                          child: Text(
                            'اضافه کردن تسک',
                            style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color(0xff18DAA3),
                            minimumSize: Size(200, 48),
                          ))
                    ],
                  ),
                ),
              ),
            ),
          ],
        ));
  }

  addTask(String taskTitle, String subTitle) {
    var task = Tasks(Title: taskTitle, SubTitle: subTitle);
    box1.add(task);
  }
}
