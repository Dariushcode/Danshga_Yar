import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:danshga_yar/HomePage.dart';

enum Gender { male, female }

class WelcomePage extends StatefulWidget {
  const WelcomePage({Key? key}) : super(key: key);

  @override
  _WelcomePageState createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  TextEditingController _nameController = TextEditingController();
  Gender _selectedGender = Gender.male;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text('دانشگاه یار'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Image(image: AssetImage('images/welcome.png')),
                Directionality(
                  textDirection: TextDirection.rtl,
                  child: Column(
                    children: [
                      Text(
                        'خوش آمدید!',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 16),
                      TextField(
                        maxLength: 26,
                        cursorColor: Colors.greenAccent,
                        controller: _nameController,
                        decoration: InputDecoration(
                          labelText: 'نام شما',
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
                      ),
                      SizedBox(height: 16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Radio(
                            activeColor: Colors.blueAccent,
                            value: Gender.male,
                            groupValue: _selectedGender,
                            onChanged: (Gender? value) {
                              setState(() {
                                _selectedGender = value!;
                              });
                            },
                          ),
                          Row(
                            children: [
                              Text(
                                'آقا',
                                style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.blueAccent,
                                ),
                              ),
                              Icon(
                                Icons.man_outlined,
                                color: Colors.blueAccent,
                              ),
                            ],
                          ),
                          SizedBox(width: 16),
                          Radio(
                            activeColor: Colors.pink,
                            value: Gender.female,
                            groupValue: _selectedGender,
                            onChanged: (Gender? value) {
                              setState(() {
                                _selectedGender = value!;
                              });
                            },
                          ),
                          Row(
                            children: [
                              Text(
                                'خانم',
                                style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.pink,
                                ),
                              ),
                              Icon(
                                Icons.woman_outlined,
                                color: Colors.pink,
                              )
                            ],
                          ),
                        ],
                      ),
                      SizedBox(height: 16),
                      ElevatedButton(
                          onPressed: () async {
                            if (_nameController.text.isNotEmpty) {
                              SharedPreferences prefs =
                                  await SharedPreferences.getInstance();
                              await prefs.setString(
                                  'userName', _nameController.text);
                              await prefs.setString(
                                  'userGender', _selectedGender.toString());

                              Navigator.of(context).pushReplacement(
                                MaterialPageRoute(builder: (_) => HomePage()),
                              );
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  backgroundColor: Colors.greenAccent,
                                  content: Text(
                                    'لطفاً نام خود را وارد کنید',
                                    textAlign: TextAlign.right,
                                    style: TextStyle(
                                      fontSize: 15,
                                    ),
                                  ),
                                  duration: Duration(seconds: 2),
                                ),
                              );
                            }
                          },
                          child: Text(
                            'ورود به برنامه',
                            style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color(0xff18DAA3),
                            minimumSize: Size(200, 48),
                          )),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
