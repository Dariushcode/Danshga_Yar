import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class SecondPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('تماس با دانشگاه '),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Directionality(
            textDirection: TextDirection.rtl,
            child: ListView(
              children: [
                buildSectionTitle('آدرس'),
                buildSectionContent(
                    'نشانی: تهران، بزرگراه خلیج فارس، روبروی حرم امام خمینی(ره)، دانشگاه آزاد اسلامی واحد یادگار امام خمینی(ره) شهرری. دسترسی: ایستگاه مترو شاهد (خط ۱)\n'
                    ' کد پستی: ۱۸۱۵۱۶۳۱۱۱\n'),
                buildSectionButton2(),
                buildSectionContent('\n'
                    '\n'
                    'تلفن: ۵۵۲۲۹۲۰۰\n'
                    'ساعات پاسخگویی: ۷/۳۰ الی۵۰ /۱۴ (شنبه لغایت چهارشنبه)'),
                buildSectionButton(),
                buildSectionButton3()
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildSectionImage(String imageName) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Image.asset(
        imageName,
        fit: BoxFit.cover,
      ),
    );
  }

  Widget buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Text(
        title,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 18.0,
        ),
      ),
    );
  }

  Widget buildSectionButton() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 38.0),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          elevation: 50,
          backgroundColor: Colors.green.shade500,
        ),
        onPressed: () {
          var urltour = Uri(path: '02155229200', scheme: 'tel');
          launchUrl(urltour);
        },
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'تماس ',
              style: TextStyle(color: Colors.white),
            ),
            Icon(
              Icons.phone,
              color: Colors.white,
            )
          ],
        ),
      ),
    );
  }

  Widget buildSectionButton3() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 38.0),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          elevation: 50,
          backgroundColor: Colors.green.shade500,
        ),
        onPressed: () {
          var urltour = Uri(path: '02155229390', scheme: 'tel');
          launchUrl(urltour);
        },
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'تماس(دفتر آقای ستارزاده) ',
              style: TextStyle(color: Colors.white),
            ),
            Icon(
              Icons.phone,
              color: Colors.white,
            )
          ],
        ),
      ),
    );
  }

  Widget buildSectionButton2() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 38.0),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          elevation: 50,
          backgroundColor: const Color(0xff1976d2),
        ),
        onPressed: () {
          var urltour = Uri.parse(
              'https://neshan.org/maps/routing/car/destination/35.5586681,51.362718099999995/poi_hash/46c0d0284e6b10cf2027b7e8f8dd2eb5');
          launchUrl(
            urltour,
            mode: LaunchMode.platformDefault,
          );
        },
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'مسیریابی در نشان',
              style: TextStyle(color: Colors.white),
            ),
            Icon(
              Icons.location_on,
              color: Colors.white,
            )
          ],
        ),
      ),
    );
  }

  // ... بخش‌های دیگر کد

  Widget buildSectionContent(String content) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Text(content),
    );
  }
}
