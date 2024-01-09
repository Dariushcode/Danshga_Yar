import 'package:danshga_yar/HomePage.dart';
import 'package:danshga_yar/AddTaskPage.dart';
import 'package:danshga_yar/SpalshScreen.dart';
import 'package:danshga_yar/Tasks.dart';
import 'package:danshga_yar/WelcomePage.dart';
import 'package:danshga_yar/barbutton.dart';
import 'package:danshga_yar/style/color.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

void main() async {
  await Hive.initFlutter();

  Hive.registerAdapter(TasksAdapter());
  await Hive.openBox<Tasks>('TasksBox');
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp, // صفحه عمودی
      DeviceOrientation.portraitDown, // صفحه عمودی
    ]);
    return MaterialApp(
      theme: ThemeData(fontFamily: 'SM'),
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: SplashScreen(),
      ),
    );
  }
}
