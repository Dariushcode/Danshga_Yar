import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutUniversityPage extends StatelessWidget {
  const AboutUniversityPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('درباره دانشگاه'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Directionality(
          textDirection: TextDirection.rtl,
          child: ListView(
            children: [
              // تاریخچه
              buildSectionTitle('تاریخچه'),
              buildSectionContent(
                  'دانشگاه آزاد اسلامی واحد یادگار امام خمینی(ره) شهرری فعالیت خود را در خرداد ماه سال 1364 در چهار رشته الهیات و معارف اسلامی، کشاورزی، الکترونیک و مکانیک در مقاطع کاردانی و کارشناسی پس از پذیرش 62 دانشجو آغاز کرد. این واحد دانشگاهی دارای 350 رشته تحصیلی در مقاطع دکتری، کارشناسی‌ارشد، کارشناسی و کاردانی در شاخه‌های برق و کامپیوتر، فنی و مهندسی، هنر و معماری، علوم انسانی و علوم پایه می‌باشد و هم اکنون بالغ بر 24 هزار دانشجو در آن مشغول به تحصیل هستند.'),
              // تاریخچه - عکس
              buildSectionImage('images/about1.jpg'),
              // دانشکده‌ها و مراکز
              buildSectionTitle('دانشکده‌ها و مراکز'),
              buildSectionContent('دانشکده مصوب مهندسی برق و کامپیوتر\n'
                  'دانشکده مصوب فنی و مهندسی و علوم پایه\n'
                  'دانشکده مدیریت و حسابداری\n'
                  'دانشکده علوم انسانی\n'
                  'مجتمع ابوالفتوح رازی\n'
                  // ... (دانشکده‌ها و مراکز دیگر)
                  ),

              // امکانات و ویژگی‌ها
              buildSectionTitle('امکانات و ویژگی‌ها'),
              buildSectionContent('بیش از 100 آزمایشگاه، کارگاه و آتلیه\n'
                  'آزمایشگاه همکار استاندارد نساجی و پوشاک\n'
                  'کتابخانه مجهز با بیش از 175 هزار جلد کتاب\n'
                  'سالن‌های تربیت بدنی و بدنسازی\n'
                  'نمازخانه‌ها، کانون‌های فرهنگی\n'
                  // ... (امکانات و ویژگی‌ها دیگر)
                  ),
              buildSectionButton(),

              // وضعیت کنونی
              buildSectionTitle('وضعیت کنونی'),
              // تاریخچه - عکس
              buildSectionImage('images/boss.jpg'),
              buildSectionContent(
                  'این واحد دانشگاهی دارای  350 رشته تحصیلی در مقاطع دکتری، کارشناسی‌ارشد، کارشناسی و کاردانی در شاخه‌های برق و کامپیوتر، فنی و مهندسی، هنر و معماری، علوم انسانی و علوم پایه می‌باشد و هم اکنون بالغ بر 21 هزار دانشجو در آن مشغول به تحصیل هستند.\n\n'
                  'امروزه این دانشگاه با فضایی سرسبز و با نشاط در زمینی به مساحت 84 هکتار، از همکاری بالغ بر 300 نفر عضو هیأت علمیِ تمام وقت در رشته‌های مختلف برخوردار است. دانشگاه آزاد اسلامی واحد یادگار امام خمینی(ره) شهرری یکی از بزرگترین سایت‌های دانشگاهی دانشگاه آزاد اسلامی در استان تهران می‌باشد.\n\n'
                  'واحد یادگار امام خمینی(ره) شهرری  دارای دانشکده مصوب مهندسی برق و کامپیوتر، فنی و مهندسی و علوم پایه، هنر و معماری، مدیریت و حسابداری، علوم انسانی و همچنین مجتمع ابوالفتوح رازی به عنوان اولین مجتمع ویژه تحصیل مادران و خواهران در استان تهران، و نیز دانشکده‌های مهارت و کار آفرینی پاسداران، جنت‌آباد، تهرانسر،  قلهک و شیخ صدوق(ره) و همچنین دارای یک مدرسه در دوره ابتدایی و متوسطه اول واقع در شهرری و یک هنرستان فنی و حرفه‌ای واقه در کن می‌باشد.\n\n'
                  'این واحد دارای مرکز رشد واحدهای فن آور، حوزه برنامه‌ریزی و امور اقتصادی دانش بنیان، مرکز فناوری اطلاعات، کتابخانه دیجیتال، مزرعه بزرگ آموزشی و تحقیقاتی، سوله‌های آموزشی، 5 مرکز تحقیقات اکوفیزیولوژی گیاهان زارعی و دارویی، نساجی، آمایش سرزمین، نیرو و انرژی و شیمی و فناوری‌های نوین و همچنین دارای کلینیک صنعت در شهرک صنعتی شمس‌آباد به منظور ایجاد ارتباط بین صنعت و دانشگاه و حل مشکلات واحدهای تولیدی و صنعتی است.\n\n'
                  'از جمله امکاناتی که دانشجویان این دانشگاه در اختیار دارند می‌توان به بیش از 100 آزمایشگاه، کارگاه  و آتلیه و همچنین آزمایشگاه همکار استاندارد نساجی و پوشاک با محیط مناسب و دستگاه‌های پیشرفته، کتابخانه مجهز با بیش از 175 هزار جلد کتاب، سالن‌های تربیت بدنی و سالن بدنسازی مناسب و مجهز، نمازخانه‌ها، کانون‌های فرهنگی، سالن غذاخوری و رستوران، کلینیک سلامت (با حضور پزشک معتمد) اشاره کرد.\n\n'
                  'به واسطه امکانات ورزشی، استادان و مربیان مجرب، تعدادی از دانشجویان این دانشگاه توانسته‌اند در رشته‌های مختلف ورزشی مدال‌های بین‌المللی و ملی کسب کنند.\n\n'
                  'از دیگر مزایای تحصیل در این دانشگاه می‌توان به تسهیلات ویژه از جمله اختصاص وام مناسب برای تحصیل و دسترسی آسان از نقاط مختلف شهر تهران و نیز فرودگاه امام خمینی(ره) اشاره نمود.\n\n'
                  'مدرسه ابتدایی سما و هنرستان فنی و حرفه‌ای پسرانه وابسته به واحد یادگار امام خمینی(ره) شهرری  و ساختمان شیخ صدوق(ره)  ویژه آموزش‌های مهارتی در شهرری از دیگر مراکز آموزشی برای فراگیران عرصه علم و فناوری می‌باشد.\n\n'
                  'همچنین این واحد دانشگاهی با بیش از 100 هزار فارغ التحصیل نقش به سزایی در ارتقای اهداف عالیه نظام آموزش عالی کشور داشته‌است که بسیاری از این فارغ التحصیلان جذب موسسات و سازمان‌های مختلف شده‌اند.\n\n'
                  'همچنین دانشگاه آزاد اسلامی واحد یادگار امام خمینی(ره)  به عنوان دانشگاه مهارتی -  کارآفرین  امکانات مطلوبی را برای ادامه تحصیل دانشجویان خارجی از قبیل خوابگاه، رستوران و انتقال از خوابگاه به دانشگاه فراهم آورده‌است.'),
            ],
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
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: ElevatedButton(
        onPressed: () {
          var urltour = Uri.parse(
              'https://www.wemeta3d.com/wp-content/uploads/2023/10/yadegar-uni-site.html');
          launchUrl(urltour, mode: LaunchMode.inAppWebView);
        },
        child: const Text('تور مجازی دانشگاه آزاد اسلامی واحد یادگار امام  '),
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
