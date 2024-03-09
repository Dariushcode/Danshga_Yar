import 'package:danshga_yar/pages/EditText.dart';
import 'package:danshga_yar/Tasks.dart';
import 'package:flutter/material.dart';
import 'package:msh_checkbox/msh_checkbox.dart';

class TaskWidget extends StatefulWidget {
  const TaskWidget({Key? key, required this.task}) : super(key: key);

  final Tasks task;

  @override
  State<TaskWidget> createState() => _TaskWidgetState();
}

class _TaskWidgetState extends State<TaskWidget> {
  bool isBoxChecked = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    isBoxChecked = widget.task.isDone;
  }

  @override
  Widget build(BuildContext context) {
    double textScaleFactor = MediaQuery.of(context).textScaleFactor;

    return GestureDetector(
      onTap: () {
        setState(() {
          isBoxChecked = !isBoxChecked;
          widget.task.isDone = isBoxChecked;
          widget.task.save();
        });
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 5,
              blurRadius: 7,
              offset: const Offset(0, 3),
            ),
          ],
          borderRadius: BorderRadius.circular(20),
        ),
        margin: const EdgeInsets.symmetric(horizontal: 24),
        height: MediaQuery.of(context).size.height * 0.13,
        width: double.infinity,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: MSHCheckbox(
                            colorConfig:
                                MSHColorConfig.fromCheckedUncheckedDisabled(
                              checkedColor: Colors.greenAccent,
                            ),
                            style: MSHCheckboxStyle.stroke,
                            value: isBoxChecked,
                            size: textScaleFactor * 32,
                            onChanged: (selected) {
                              setState(() {
                                isBoxChecked = selected;
                              });
                            },
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 4,
                        child: GetTitle(),
                      ),
                    ],
                  ),
                  const Spacer(),
                  Expanded(
                    child: getEditAndTimeButton(),
                    flex: 8,
                  ),
                ],
              ),
            ),
            const Padding(
              padding: EdgeInsets.all(12.0),
              child: Image(image: AssetImage('images/college1.png')),
            ),
          ],
        ),
      ),
    );
  }

  Column GetTitle() {
    final textScaleFactor = MediaQuery.textScaleFactorOf(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Padding(
          padding: const EdgeInsets.all(4.0),
          child: Text(
            widget.task.Title,
            style: TextStyle(
              fontSize: textScaleFactor * 18,
              fontWeight: FontWeight.bold,
            ),
            maxLines: 1, // حداکثر یک خط نمایش داده شود
            overflow: TextOverflow
                .ellipsis, // اگر متن بیشتر از حداکثر یک خط باشد، از این استایل استفاده می‌کند
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(4.0),
          child: Text(
            widget.task.SubTitle,
            style: TextStyle(
              fontSize: textScaleFactor * 12,
              fontWeight: FontWeight.normal,
            ),
            maxLines: 2,
            overflow: TextOverflow.visible,
          ),
        ),
      ],
    );
  }

  Row getEditAndTimeButton() {
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
          child: Container(
            height: 28,
            width: 83,
            decoration: const BoxDecoration(
              color: Color(0xff18DAA3),
              borderRadius: BorderRadius.all(Radius.circular(18)),
            ),
            child: Row(
              children: [
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 6, horizontal: 12),
                  child: Image(
                    image: AssetImage(
                      'images/icon_time.png',
                    ),
                  ),
                ),
                Text(
                  '${widget.task.time.hour}:${widget.task.time.minute}',
                  style: const TextStyle(
                      fontSize: 13, fontWeight: FontWeight.bold),
                )
              ],
            ),
          ),
        ),
        InkWell(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            child: Container(
              height: 28,
              width: 83,
              decoration: const BoxDecoration(
                color: Color(0xffE2F6F1),
                borderRadius: BorderRadius.all(Radius.circular(18)),
              ),
              child: const Row(
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 6, horizontal: 12),
                    child: Image(
                      image: AssetImage(
                        'images/icon_edit.png',
                      ),
                    ),
                  ),
                  Text(
                    'ویرایش ',
                    style: TextStyle(fontSize: 12),
                  )
                ],
              ),
            ),
          ),
          onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return EditTeskScreen(
                task: widget.task,
              );
            }));
          },
        )
      ],
    );
  }
}
