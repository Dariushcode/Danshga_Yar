import 'dart:async';
import 'dart:math';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:simple_circular_progress_bar/simple_circular_progress_bar.dart';

import 'HomePage.dart';
import 'WelcomePage.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Color?> _backgroundColor;
  double scaleFactor = 40.0;
  double blur = 0.0; // انعکاس پس‌زمینه

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 3),
    );

    _backgroundColor = ColorTween(
      begin: Colors.white,
      end: Colors.greenAccent, // رنگ جدید پس‌زمینه
    ).animate(_controller);

    _controller.repeat(reverse: true);

    Future.delayed(Duration(seconds: 3), () {
      setState(() {
        scaleFactor = 0.1;
        blur = 10.0; // افزایش انعکاس پس‌زمینه
      });
      navigateToNextPage();
    });
  }

  void navigateToNextPage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool showWelcomePage = prefs.getBool('showWelcomePage') ?? true;

    if (showWelcomePage) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (_) => WelcomePage()),
      );
      await prefs.setBool('showWelcomePage', false);
    } else {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (_) => HomePage()),
      );
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          return Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [_backgroundColor.value!, Colors.blue.shade200],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: Center(
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: blur, sigmaY: blur),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Hero(
                      tag: 'دانشگاه یار ',
                      child: Image.asset(
                        'images/azad.png',
                        height: 100,
                        width: 100,
                      ),
                    ),
                    Column(
                      children: [
                        AnimatedTextKit(
                          animatedTexts: [
                            TyperAnimatedText(
                              'دانشگاه یار',
                              textStyle: TextStyle(
                                color: Colors.white,
                                fontSize: 38,
                                fontWeight: FontWeight.bold,
                              ),
                              speed: Duration(milliseconds: 200),
                            ),
                          ],
                        ),
                        SizedBox(height: 26),
                        const SimpleCircularProgressBar(
                          mergeMode: true,
                          size: 40,
                          progressStrokeWidth: 4,
                          animationDuration: 2,
                          backStrokeWidth: 0,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: SplashScreen(),
    debugShowCheckedModeBanner: false,
  ));
}
