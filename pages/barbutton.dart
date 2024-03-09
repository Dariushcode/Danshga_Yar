import 'package:danshga_yar/pages/AirQualityPage.dart';
import 'package:danshga_yar/pages/HomePage.dart';
import 'package:danshga_yar/pages/TaskPage.dart';
import 'package:danshga_yar/pages/settinges.dart';
import 'package:danshga_yar/style/color.dart';
import 'package:flutter/material.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

import 'AddTaskPage.dart';
import '../main.dart';

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
        /// setting
        SalomonBottomBarItem(
          icon: InkWell(
            onTap: () {
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => const Settings()),
                (route) => true,
              );
            },
            child: Padding(
              padding: const EdgeInsets.all(5.0),
              child: Icon(
                Icons.settings_outlined,
                color: _currentIndex == 0 ? Maincolor : buttonbaricon1,
                size: MediaQuery.of(context).size.height * 0.03,
              ),
            ),
          ),
          title: const Text(""),
          selectedColor: Maincolor,
        ),

        /// planner
        SalomonBottomBarItem(
          icon: InkWell(
            borderRadius: const BorderRadius.all(Radius.circular(30)),
            splashColor: Maincolor,
            onTap: () {
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => const air()),
                (route) => true,
              );
            },
            child: Icon(
              Icons.air,
              color: _currentIndex == 1 ? Maincolor : buttonbaricon1,
              size: MediaQuery.of(context).size.height * 0.03,
            ),
          ),
          title: const Text(""),
          selectedColor: Maincolor,
        ),

        /// add task
        SalomonBottomBarItem(
          icon: InkWell(
            borderRadius: const BorderRadius.all(Radius.circular(30)),
            splashColor: Maincolor,
            onTap: () {
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => const AddTeskScreen()),
                (route) => true,
              );
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Icon(
                Icons.add_task,
                color: _currentIndex == 2
                    ? Colors.greenAccent.shade700
                    : buttonbaricon1,
                size: MediaQuery.of(context).size.height * 0.06,
              ),
            ),
          ),
          title: const Text(""),
          selectedColor: Colors.greenAccent.shade700,
        ),

        /// tasks
        SalomonBottomBarItem(
          icon: InkWell(
            borderRadius: const BorderRadius.all(Radius.circular(30)),
            splashColor: Maincolor,
            onTap: () {
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => TaskPage()),
                (route) => true,
              );
            },
            child: Icon(
              Icons.task_outlined,
              color: _currentIndex == 3 ? Maincolor : buttonbaricon1,
              size: MediaQuery.of(context).size.height * 0.03,
            ),
          ),
          title: const Text(""),
          selectedColor: Maincolor,
        ),

        /// home
        SalomonBottomBarItem(
          icon: InkWell(
            borderRadius: const BorderRadius.all(Radius.circular(30)),
            splashColor: Maincolor,
            onTap: () {
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => const HomePage()),
                (route) => false,
              );
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Icon(
                Icons.home_outlined,
                color: _currentIndex == 4 ? Maincolor : buttonbaricon1,
                size: MediaQuery.of(context).size.height * 0.03,
              ),
            ),
          ),
          title: const Text(""),
          selectedColor: Maincolor,
        ),
      ],
    );
  }
}
