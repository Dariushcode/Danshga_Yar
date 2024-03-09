import 'package:danshga_yar/pages/SpalshScreen.dart';
import 'package:danshga_yar/Tasks.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  await Hive.initFlutter();

  Hive.registerAdapter(TasksAdapter());
  await Hive.openBox<Tasks>('TasksBox');
  runApp(const MyApp());
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
      theme: ThemeData(
          fontFamily: 'SM',
          canvasColor: const Color(0xff18DAA3),
          colorScheme: const ColorScheme(
            brightness: Brightness.light,
            primary: Colors.orangeAccent,
            onPrimary: Color(0xff0E8160),
            secondary: Color(0xff14B889),
            onSecondary: Color(0xff0E8160),
            error: Colors.redAccent,
            onError: Colors.red,
            background: Colors.white,
            onBackground: Color(0xffd5e5f6),
            surface: Colors.white,
            onSurface: Colors.teal,
          )),
      debugShowCheckedModeBanner: false,
      home: const Scaffold(
        body: SplashScreen(),
      ),
    );
  }
}
