import 'package:danshga_yar/pages/aboutme.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'HomePage.dart';

class Settings extends StatefulWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  final TextEditingController _nameController = TextEditingController();
  String userName = '';
  String userGender = '';
  String userImage = '';
  Color highlightColor = Colors.white;
  bool _isNameValid = false;
  late List<String> profileImages;
  int selectedImageIndex = -1;

  @override
  void initState() {
    super.initState();
    profileImages = [
      'images/pic9.gif',
      'images/pic10.gif',
      'images/pro3.gif',
      'images/women.png',
      'images/pic11.gif',
      'images/men.png',
      'images/pro4.png',
      'images/pro5.png',
      'images/pro7.png',
      'images/pro1.png',
      'images/men.gif',
      'images/women.gif',

      // Add more images as needed
    ];

    getUserInfo();
  }

  Future<void> getUserInfo() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      userName = prefs.getString('userName') ?? '';
      userGender = prefs.getString('userGender') ?? '';
      userImage = prefs.getString('userProfileImage') ?? '';
    });
  }

  Future<void> setUserInfo(String newProfile) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('userProfileImage', newProfile);
  }

  Future<void> setUserInfoname(String newName) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('userName', newName);
  }

  void _validateName(String value) {
    setState(() {
      _isNameValid =
          value.isNotEmpty; // اگر نام معتبر باشد _isNameValid را true می‌کنیم
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Settings'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(1.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 8.0,
                  mainAxisSpacing: 8.0,
                ),
                itemCount: profileImages.length,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      setState(() {
                        if (selectedImageIndex == index) {
                          selectedImageIndex =
                              -1; // دوباره روی همان عکس کلیک شده است
                        } else {
                          selectedImageIndex = index;
                        }
                      });

                      setUserInfo(profileImages[index]);
                      Navigator.of(context).push(
                          MaterialPageRoute(builder: (_) => const HomePage()));
                    },
                    child: CircleAvatar(
                      backgroundColor: selectedImageIndex == index
                          ? Colors.green
                          : Colors.white.withOpacity(0.1),
                      radius: 40,
                      backgroundImage: AssetImage(profileImages[index]),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 16),
            Text('نام فعلی شما : $userName'),
            const SizedBox(height: 16),
            TextField(
              maxLength: 26,
              cursorColor: Colors.greenAccent,
              controller: _nameController,
              onChanged: _validateName,
              decoration: const InputDecoration(
                labelText: 'نام جدید را وارد کنید',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(15)),
                  borderSide: BorderSide(
                    color: Color(0xffC5C5C5),
                    width: 3.0,
                  ),
                ),
                filled: true,
                fillColor: Color(0xffddf4e4),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(15)),
                  borderSide: BorderSide(
                    width: 3,
                    color: Color(0xff18DAA3),
                  ),
                ),
                contentPadding:
                    EdgeInsets.symmetric(vertical: 16.0, horizontal: 20.0),
                errorBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.red, width: 2.0),
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                ),
                focusedErrorBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.red, width: 2.0),
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                ),
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xff98EBD4),
                minimumSize: const Size(200, 48),
              ),
              onPressed: _isNameValid
                  ? () {
                      setUserInfoname(_nameController.text);
                    }
                  : null,
              child: const Text('تغییر نام'),
            ),
            const Expanded(child: SizedBox(height: 16)),
            // افزودن دکمه ارسال ایمیل با انیمیشن و InkWell
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                elevation: 39,
                backgroundColor: Colors.grey.shade200,
                minimumSize: const Size(300, 48),
              ),
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return AboutMePage();
                }));
              },
              child: const Text('About ME'),
            ),
          ],
        ),
      ),
    );
  }
}
