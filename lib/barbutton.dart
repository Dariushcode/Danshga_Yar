import 'package:danshga_yar/HomePage.dart';
import 'package:danshga_yar/style/color.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

import 'AddTaskPage.dart';

class BarButton extends StatefulWidget {
  const BarButton({super.key});

  @override
  State<BarButton> createState() => _BarButtonState();
}

class _BarButtonState extends State<BarButton> {
  int _currentIndex = 2;

  @override
  Widget build(BuildContext context) {
    return SalomonBottomBar(
      currentIndex: _currentIndex,
      onTap: (i) => setState(() => _currentIndex = i),
      items: [
        ///setting
        SalomonBottomBarItem(
          icon: Padding(
            padding: const EdgeInsets.all(5.0),
            child: Icon(
              Icons.settings_outlined,
              color: buttonbaricon1,
              size: 28,
            ),
          ),
          title: Text(""),
          selectedColor: Colors.white,
        ),

        /// planner
        SalomonBottomBarItem(
          icon: InkWell(
            borderRadius: BorderRadius.all(Radius.circular(30)),
            splashColor: Colors.red,
            onTap: () {
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => AddTeskScreen()),
                (route) => true,
              );
            },
            child: Icon(
              Icons.calendar_month_outlined,
              color: buttonbaricon1,
              size: 28,
            ),
          ),
          title: Text(""),
          selectedColor: Colors.white,
        ),

        /// add task
        SalomonBottomBarItem(
          icon: InkWell(
            borderRadius: BorderRadius.all(Radius.circular(30)),
            splashColor: Colors.red,
            onTap: () {
              setState(() {
                _currentIndex = 2;
              });
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => AddTeskScreen()),
                (route) => true,
              );
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Icon(
                Icons.add_task,
                color: buttonbaricon1,
                size: 38,
              ),
            ),
          ),
          title: Text(""),
          selectedColor: Colors.greenAccent.shade700,
        ),

        /// tasks
        SalomonBottomBarItem(
          icon: Icon(
            Icons.task_outlined,
            color: buttonbaricon1,
            size: 28,
          ),
          title: Text(""),
          selectedColor: Colors.white,
        ),

        /// home
        SalomonBottomBarItem(
          icon: InkWell(
            borderRadius: BorderRadius.all(Radius.circular(30)),
            splashColor: Colors.red,
            onTap: () {
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => HomePage()),
                (route) => false,
              );
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Icon(
                Icons.home_outlined,
                color: buttonbaricon1,
                size: 28,
              ),
            ),
          ),
          title: Text(""),
          selectedColor: Colors.white,
        ),
      ],
    );
  }
}
