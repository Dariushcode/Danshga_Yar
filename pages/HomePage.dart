import 'dart:math';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:danshga_yar/Tasks.dart';
import 'package:danshga_yar/pages/barbutton.dart';
import 'package:connectivity/connectivity.dart';
import 'package:danshga_yar/pages/settinges.dart';
import 'package:danshga_yar/pages/aboutme.dart';
import 'package:danshga_yar/style/color.dart';
import 'package:danshga_yar/style/telegram.dart';
import 'package:danshga_yar/style/textthem.dart';
import 'package:danshga_yar/style/widget_task.dart';
import 'package:flutter/material.dart';

import 'package:hive/hive.dart';
import 'package:danshga_yar/pages/EditText.dart';

import 'package:persian_toolbox/persian_toolbox.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import 'AddTaskPage.dart';
import 'aboutUnversity.dart';
import 'contect.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String userName = 'images/icon_add.png'; //
  String userGender = '';
  String userImage = 'images/unkown.png';

  final List<String> backgroundImages = [
    'images/college1.png',
    'images/college2.png',
    'images/college3.png',
    'images/clloege4.gif',
    'images/clloege6.gif',
    'images/clloege7.gif',
    'images/clloege8.gif',
    'images/clloege9.gif',
    'images/c1.gif',
    'images/f4.gif',
    'images/c2.gif',
    'images/c3.gif',
    'images/c4.gif',
    'images/g2.gif',
    'images/e1.gif',
    'images/e1.gif',
    'images/f2.gif',
    'images/f1.gif',
    'images/f3.gif',
    'images/f5.gif',
    'images/g1.gif',
    'images/f6.gif',
  ];
  final List<String> greetings = [
    ' سلام',
    ' خوبی؟',
    ' صبح بخیر',
    'وقت بخیر',
    ' خداقوت',
    ' ایام به کام',
    'خوش آمدید',
    'درود',
    'سلام دوست عزیزم',
    // Add more greetings as needed
  ];

  String getRandomGreeting() {
    final Random random = Random();
    return greetings[random.nextInt(greetings.length)];
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
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

  String getRandomBackgroundImage() {
    final Random random = Random();
    return backgroundImages[random.nextInt(backgroundImages.length)];
  }

  final box = Hive.box<Tasks>('TasksBox');
  @override
  Widget build(BuildContext context) {
    var taskCount = 0;

    taskCount = box.values.length;
    return Scaffold(
      bottomNavigationBar: BarButton(),
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            SliverAppBar(
              automaticallyImplyLeading: false,
              surfaceTintColor: Colors.transparent,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(40.0),
                  bottomRight: Radius.circular(40.0),
                ),
              ),
              pinned: true,
              snap: true,
              stretch: true,
              floating: true,
              expandedHeight: MediaQuery.of(context).size.height * 0.21,
              flexibleSpace: FlexibleSpaceBar(
                background: Stack(
                  fit: StackFit.expand,
                  children: [
                    ClipRRect(
                      borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(40.0),
                        bottomRight: Radius.circular(40.0),
                      ),
                      child: Image.asset(
                        getRandomBackgroundImage(),
                        fit: BoxFit.cover,
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Colors.transparent,
                            Colors.black.withOpacity(0.5),
                          ],
                        ),
                      ),
                    ),
                    Positioned(
                      top: 0,
                      left: 0,
                      right: 0,
                      child: AppBar(
                        backgroundColor: Colors.transparent,
                        elevation: 0,
                      ),
                    ),
                    Positioned(
                      bottom: 36,
                      left: 16,
                      right: 16,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            vertical: 16, horizontal: 24),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.9),
                          borderRadius: BorderRadius.circular(38),
                        ),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Icon(
                                    Icons.calendar_month_outlined,
                                    size: 16,
                                    color: Color(0xff0E8160),
                                  ),
                                ),
                                Text(_getFormattedPersianDate()),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Flexible(
                                  child: Text(
                                    ' $userName',
                                    style: const TextStyle(
                                        color: Colors.greenAccent,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 17),
                                  ),
                                ),
                                Flexible(
                                  child: Padding(
                                    padding: const EdgeInsets.all(3.0),
                                    child: Text(
                                      getRandomGreeting(), //متن خوش امدگویی
                                      style: TextStyle(
                                          color: Colors.greenAccent,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 17),
                                    ),
                                  ),
                                ),
                                // Display today's date on the left side of the app bar

                                Padding(
                                  padding: const EdgeInsets.only(left: 6),
                                  child: Container(
                                    height: 69,
                                    width: 69,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Colors.white,
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.black.withOpacity(0.2),
                                          blurRadius: 8,
                                          offset: const Offset(0, 4),
                                        ),
                                      ],
                                    ),
                                    child: InkWell(
                                      onTap: () {
                                        Navigator.push(context,
                                            MaterialPageRoute(
                                                builder: (context) {
                                          return Settings();
                                        }));
                                      },
                                      child: ClipOval(
                                        child: Image.asset(
                                          userImage,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                stretchModes: [StretchMode.zoomBackground],
              ),
              collapsedHeight: 60,
              title: const Padding(
                padding: EdgeInsets.all(38.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Text(
                    //   'دانشگاه یار',
                    //   style: TextStyle(
                    //     color: Colors.black,
                    //     fontWeight: FontWeight.bold,
                    //     fontSize: 38,
                    //   ),
                    // ),
                  ],
                ),
              ),
            ),
          ];
        },
        body: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
            final Size screenSize = MediaQuery.of(context).size;
            double cardHeight = screenSize.height * 0.2;
            double cardWidth = screenSize.width * 0.4;

            return ConstrainedBox(
              constraints: const BoxConstraints(maxHeight: 200),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      '  خدمات الکترونیک',
                      style: CustomTextStyle.title,
                    ),
                  ),
                  Directionality(
                    textDirection: TextDirection.rtl,
                    child: carouselItems(context),
                  ),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.white,
                                      elevation: 5,
                                      shadowColor: Maincolor,
                                      foregroundColor: Maincolor,
                                      surfaceTintColor: Colors.white),
                                  onPressed: () {
                                    Navigator.pushAndRemoveUntil(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const AddTeskScreen()),
                                      (route) => true,
                                    );
                                  },
                                  child: Row(
                                    children: [
                                      Icon(
                                        Icons.add_task,
                                        color: Maincolor,
                                      ),
                                      Text(
                                        '   افزودن تسک  ',
                                        style: TextStyle(
                                            color: Maincolor, fontSize: 12),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              const Text(
                                '   تسک فعال در امروز  ',
                                style: CustomTextStyle.headline3,
                              ),
                              Text(
                                ' $taskCount  ',
                                style: TextStyle(
                                  fontSize: 25,
                                  color: Colors.green.shade700,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  Expanded(
                    child: ListView.separated(
                      separatorBuilder: (context, index) => const SizedBox(
                          height: 16), // افزودن یک فاصله 16 پیکسل بین هر آیتم
                      itemBuilder: (context, index) {
                        var tasks = box.values.toList()[index];
                        return GetTaskWidget(tasks);
                      },
                      itemCount: box.values.length,
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Widget GetTaskWidget(Tasks tasks) {
    return Dismissible(
      key: UniqueKey(),
      onDismissed: (direction) {
        if (direction == DismissDirection.startToEnd) {
          // به سمت چپ کشیده شده و حذف شده
          setState(() {
            tasks.delete();
          });
        } else if (direction == DismissDirection.endToStart) {
          // به سمت راست کشیده شده ویرایش شود

          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return EditTeskScreen(task: tasks);
          }));
        }
      },
      background: Container(
        decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(
              Radius.circular(30),
            ),
            color: Colors.redAccent),
        // رنگ پس زمینه حذف
        child: const Align(
          alignment: Alignment.centerLeft, // تنظیمات به سمت چپ
          child: Padding(
            padding: EdgeInsets.only(left: 16.0),
            child: Row(
              children: [
                Text(
                  'حذف',
                  style: TextStyle(fontSize: 19, color: Colors.white),
                ),
                Icon(
                  Icons.delete, // آیکون حذف
                  color: Colors.white,
                ),
              ],
            ),
          ),
        ),
      ),
      secondaryBackground: Container(
        decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(
              Radius.circular(30),
            ),
            color: Colors.greenAccent),
        child: const Align(
          alignment: Alignment.centerRight, // تنظیمات به سمت راست
          child: Padding(
            padding: EdgeInsets.only(right: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  'ویرایش',
                  style: TextStyle(fontSize: 19, color: Colors.white),
                ),
                Icon(
                  Icons.edit, // آیکون ویرایش
                  color: Colors.white,
                ),
              ],
            ),
          ),
        ),
      ),
      child: TaskWidget(task: tasks),
    );
  }

  String _getFormattedPersianDate() {
    DateTime dateTime = DateTime.now();
    String date = jalaliToday();

    return '$date';
  }

  Widget carouselItems(BuildContext context) {
    return CarouselSlider(
      options: CarouselOptions(
        height: 200.0,
        enlargeCenterPage: true,
        autoPlay: true,
        aspectRatio: 16 / 9,
        autoPlayCurve: Curves.easeInOutCubicEmphasized,
        enableInfiniteScroll: true,
        autoPlayAnimationDuration: const Duration(milliseconds: 1800),
        viewportFraction: 0.3,
      ),
      items: [
        carouselCard(
          context,
          cardColor2,
          'درباره دانشگاه',
          Icons.home_outlined,
          'button2',
        ),
        carouselCard(
          context,
          cardColor3,
          'ثبت نام',
          Icons.login_outlined,
          'button3',
        ),
        carouselCard(
          context,
          cardColor11,
          'آموزشیار',
          Icons.school_rounded,
          'button1',
        ),
        carouselCard(
          context,
          cardColor9,
          'سامانه وادانا',
          Icons.business_center_outlined,
          'button4',
        ),
        carouselCard(
          context,
          cardColor5,
          'سامانه فیش حقوقی',
          Icons.monetization_on_outlined,
          'button5',
        ),
        carouselCard(
          context,
          cardColor6,
          'تماس با دانشگاه',
          Icons.call_outlined,
          'button6',
        ),
        carouselCard(
          context,
          cardColor7,
          'ایمیل اساتید',
          Icons.alternate_email_outlined,
          'button7',
        ),
        carouselCard(
          context,
          cardColor10,
          'آموزشیار نسخه قدیم',
          Icons.school_outlined,
          'button9',
        ),
        carouselCard(
          context,
          cardColor8,
          'انتخاب واحد',
          Icons.pinch_outlined,
          'button8',
        ),
        carouselCard(
          context,
          Colors.purple,
          'شبکه های اجتماعی',
          Icons.social_distance,
          'button10',
        ),
      ],
    );
  }

  Widget carouselCard(
    BuildContext context,
    Color cardColor,
    String cardName,
    IconData cardIcon,
    String cardKey,
  ) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.6,
      width: MediaQuery.of(context).size.width * 0.4,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: cardColor,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 5,
            blurRadius: 7,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: LayoutBuilder(builder: (context, constraints) {
        return Stack(
          children: [
            Positioned(
              bottom: constraints.maxHeight * .55,
              left: -constraints.maxWidth * .1,
              right: -constraints.maxWidth * .1,
              child: Icon(
                cardIcon,
                color: Colors.white.withOpacity(0.5),
                size: 100,
              ),
            ),
            Positioned(
              bottom: constraints.maxHeight * .4,
              left: -constraints.maxWidth * .1,
              right: -constraints.maxWidth * .1,
              child: Icon(
                cardIcon,
                color: const Color(0xff91F3D7).withOpacity(0.5),
                size: 30,
              ),
            ),
            Positioned(
              top: constraints.maxHeight * .56,
              left: -constraints.maxWidth * .1,
              right: -constraints.maxWidth * .1,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: ElevatedButton(
                  onPressed: () {
                    checkInternetAndNavigate(context, cardKey);
                  },
                  child: Text(cardName,
                      style: TextStyle(
                          fontSize: MediaQuery.of(context).size.height * 0.019,
                          fontWeight: FontWeight.w400,
                          color: Maincolor)),
                ),
              ),
            ),
          ],
        );
      }),
    );
  }

  // Widget getCardItem(
  //   Color Card_Color,
  //   String CardName,
  //   IconData CardIcon,
  //   String cardKey,
  //   BuildContext context,
  //   double cardHeight,
  //   double cardWidth,
  // ) {
  //   return Center(
  //     child: Padding(
  //       padding: const EdgeInsets.all(10),
  //       child: Container(
  //         height: cardHeight,
  //         width: cardWidth,
  //         decoration: BoxDecoration(
  //           borderRadius: BorderRadius.circular(15),
  //           color: Card_Color,
  //           boxShadow: [
  //             BoxShadow(
  //               color: Colors.grey.withOpacity(0.5),
  //               spreadRadius: 5,
  //               blurRadius: 7,
  //               offset: const Offset(0, 3),
  //             ),
  //           ],
  //         ),
  //         child: LayoutBuilder(builder: (context, constraints) {
  //           return Stack(
  //             children: [
  //               Positioned(
  //                 bottom: constraints.maxHeight * .6,
  //                 left: -constraints.maxWidth * .1,
  //                 right: -constraints.maxWidth * .1,
  //                 child: Icon(
  //                   CardIcon,
  //                   color: Colors.white.withOpacity(0.5),
  //                   size: 100,
  //                 ),
  //               ),
  //               Positioned(
  //                 bottom: constraints.maxHeight * .4,
  //                 left: -constraints.maxWidth * .1,
  //                 right: -constraints.maxWidth * .1,
  //                 child: Icon(
  //                   CardIcon,
  //                   color: Colors.white,
  //                   size: 30,
  //                 ),
  //               ),
  //               Positioned(
  //                 top: constraints.maxHeight * .56,
  //                 left: -constraints.maxWidth * .1,
  //                 right: -constraints.maxWidth * .1,
  //                 child: Padding(
  //                   padding: const EdgeInsets.all(25.0),
  //                   child: ElevatedButton(
  //                     onPressed: () {
  //                       checkInternetAndNavigate(context, cardKey);
  //                     },
  //                     child: Text(
  //                       CardName,
  //                       style: CustomTextStyle.headline25,
  //                     ),
  //                   ),
  //                 ),
  //               ),
  //             ],
  //           );
  //         }),
  //       ),
  //     ),
  //   );
  // }
}

Future<bool> checkInternetConnection() async {
  var connectivityResult = await Connectivity().checkConnectivity();
  if (connectivityResult == ConnectivityResult.none) {
    return false; // اتصال به اینترنت وجود ندارد
  } else {
    return true; // اتصال به اینترنت وجود دارد
  }
}

Future<void> checkInternetAndNavigate(
    BuildContext context, String cardKey) async {
  bool isConnected = await checkInternetConnection();

  if (isConnected) {
    // اگر اتصال به اینترنت وجود دارد، به URL مرتبط با کلید دکمه بروید
    navigateToUrl(context, cardKey);
  } else {
    // اگر اتصال به اینترنت وجود ندارد، وضعیت آفلاین را ثبت کنید
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('اتصال به اینترنت وجود ندارد.'),
        duration: Duration(seconds: 3),
      ),
    );
  }
}

void navigateToUrl(BuildContext context, String cardKey) async {
  final Object urlObject = getCorrespondingUrl(context, cardKey);

  if (urlObject is Uri) {
    await launchUrl(urlObject, mode: LaunchMode.externalApplication);
  }
}

Object getCorrespondingUrl(BuildContext context, String cardKey) {
  if (cardKey == 'button1') {
    return Uri.parse('https://stdn.iau.ir/Student/Pages/acmstd/loginPage.jsp');
  } else if (cardKey == 'button2') {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const AboutUniversityPage()),
    );
  } else if (cardKey == 'button2') {
    return Uri.parse(
        'https://yi.iau.ir/fa/page/372/%D8%AA%D8%A7%D8%B1%DB%8C%D8%AE%DA%86%D9%87');
  } else if (cardKey == 'button3') {
    return Uri.parse('https://edu.iau.ac.ir/');
  } else if (cardKey == 'button4') {
    return Uri.parse('https://vadana31.ec.iau.ir/');
  } else if (cardKey == 'button5') {
    return Uri.parse('http://payroll.azad.ac.ir/cpayroll/login/login.aspx');
  } else if (cardKey == 'button6') {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => SecondPage()),
    );
  } else if (cardKey == 'button7') {
    return Uri.parse(
        'https://yi.iau.ir/ece/fa/page/4332/%D8%A7%D8%B9%D8%B6%D8%A7-%D9%87%DB%8C%D8%A6%D8%AA-%D8%B9%D9%84%D9%85%DB%8C-%D8%AF%D8%A7%D9%86%D8%B4%DA%A9%D8%AF%D9%87');
  } else if (cardKey == 'button8') {
    return Uri.parse('https://stdn2.iau.ir/Student/Pages/acmstd/loginPage.jsp');
  } else if (cardKey == 'button9') {
    return Uri.parse('https://stdn.iau.ir/Student/Pages/acmstd/loginPage.jsp');
  } else if (cardKey == 'button10') {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => YourPage()),
    );
  }
  return '';
}
