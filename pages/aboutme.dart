import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutMePage extends StatelessWidget {
  final String email = 'dariushnotes@gmail.com';
  final String telegramLink = 'https://t.me/your_telegram';

  void _sendEmail() async {
    final Uri emailLaunchUri = Uri(
      scheme: 'mailto',
      path: email,
      queryParameters: {'subject': 'Danshga Yar 2.2'},
    );
    launchUrl(emailLaunchUri);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('About Me'),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: SizedBox(height: MediaQuery.of(context).size.height),
            ),
            Expanded(
              child: Hero(
                tag: 'profileImage',
                child: TweenAnimationBuilder<double>(
                  tween: Tween<double>(begin: 0, end: 2.85),
                  duration: const Duration(seconds: 1),
                  builder: (BuildContext context, double value, Widget? child) {
                    return Transform.scale(
                      scale: value,
                      child: const CircleAvatar(
                        radius: 65,
                        backgroundImage: AssetImage(
                          'images/dariush.jpg',
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
            Expanded(
              child: SizedBox(height: MediaQuery.of(context).size.height),
            ),
            Expanded(
              child: const Text(
                'Dariush Yousefi',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ),
            Expanded(
              child: const Text(
                'Android Developer',
                style: TextStyle(fontSize: 18, color: Colors.grey),
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.redAccent,
                ),
                onPressed: () {
                  _sendEmail();
                },
                child: const Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.email, color: Colors.white),
                    SizedBox(width: 8),
                    Text('ایمیل', style: TextStyle(color: Colors.white)),
                  ],
                )),

            const SizedBox(height: 16),

            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.lightBlueAccent,
              ),
              onPressed: () {
                var urltour = Uri.parse('https://t.me/thisisdariush');
                launchUrl(urltour, mode: LaunchMode.externalApplication);
              },
              child: const Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.send, color: Colors.white),
                  SizedBox(width: 8),
                  Text('پیام در تلگرام', style: TextStyle(color: Colors.white)),
                ],
              ),
            ),
            const SizedBox(height: 16),
            // افزودن دکمه ورود به لینک تلگرام با انیمیشن و InkWell
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.lightGreen.withOpacity(.5),
              ),
              onPressed: () {
                var urltour =
                    Uri.parse('https://cafebazaar.ir/developer/989943102094');
                launchUrl(urltour, mode: LaunchMode.platformDefault);
              },
              child: const Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.shopping_bag, color: Colors.white),
                  SizedBox(width: 8),
                  Text('مشاهده سایر برنامه در بازار',
                      style: TextStyle(color: Colors.white)),
                ],
              ),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.lightGreen,
              ),
              onPressed: () {
                var urltour = Uri.parse(
                    'https://cafebazaar.ir/app/com.dariushcode.danshga_yar');
                launchUrl(urltour, mode: LaunchMode.externalApplication);
              },
              child: const Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.star, color: Colors.white),
                  Icon(Icons.star, color: Colors.white),
                  Icon(Icons.star, color: Colors.white),
                  SizedBox(width: 8),
                  Text('ثبت نظر در بازار',
                      style: TextStyle(color: Colors.white)),
                  SizedBox(width: 8),
                  Icon(Icons.star, color: Colors.white),
                  Icon(Icons.star, color: Colors.white),
                  Icon(Icons.star, color: Colors.white),
                ],
              ),
            ),

            // انیمیشن جذاب می‌تواند اینجا افزوده شود
          ],
        ),
      ),
    );
  }
}
