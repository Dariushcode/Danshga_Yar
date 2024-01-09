import 'dart:math';

import 'package:danshga_yar/AddTaskPage.dart';
import 'package:danshga_yar/Tasks.dart';
import 'package:danshga_yar/barbutton.dart';
import 'package:connectivity/connectivity.dart';
import 'package:danshga_yar/style/color.dart';
import 'package:danshga_yar/style/textthem.dart';
import 'package:danshga_yar/style/widget_task.dart';
import 'package:flutter/material.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:hive/hive.dart';
import 'package:msh_checkbox/msh_checkbox.dart';

import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String userName = 'images/icon_add.png'; //
  String userGender = ''; // اضافه شده
  final List<String> backgroundImages = [
    'images/college1.png',
    'images/college2.png',
    'images/college3.png',
  ];
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
    });
  }

  String getRandomBackgroundImage() {
    final Random random = Random();
    return backgroundImages[random.nextInt(backgroundImages.length)];
  }

  final box = Hive.box<Tasks>('TasksBox');
  @override
  Widget build(BuildContext context) {
    String userImage =
        (userGender == 'Gender.male') ? 'images/men.png' : 'images/women.png';

    var taskCount = 0;

    taskCount = box.values.length;
    return Scaffold(
      bottomNavigationBar: BarButton(),
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            SliverAppBar(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(40.0),
                  bottomRight: Radius.circular(40.0),
                ),
              ),
              pinned: true,
              snap: true,
              floating: true,
              expandedHeight: MediaQuery.of(context).size.height * 0.3,
              flexibleSpace: FlexibleSpaceBar(
                background: Stack(
                  fit: StackFit.expand,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.only(
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
                      bottom: 16,
                      left: 16,
                      right: 16,
                      child: Container(
                        padding:
                            EdgeInsets.symmetric(vertical: 16, horizontal: 24),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.9),
                          borderRadius: BorderRadius.circular(38),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Flexible(
                              child: Text(
                                ' $userName',
                                style: TextStyle(
                                    color: Colors.greenAccent,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16),
                              ),
                            ),
                            Text(
                              ' سلام',
                              style: TextStyle(
                                  color: Colors.greenAccent,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 25),
                            ),
                            SizedBox(width: 16),
                            Container(
                              height: 59,
                              width: 59,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.white,
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.2),
                                    blurRadius: 8,
                                    offset: Offset(0, 4),
                                  ),
                                ],
                              ),
                              child: ClipOval(
                                child: Image.asset(
                                  userImage,
                                  fit: BoxFit.cover,
                                ),
                              ),
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
              title: Padding(
                padding: const EdgeInsets.all(38.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'دانشگاه یار',
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
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

            return Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    '  خدمات الکترونیک',
                    style: CustomTextStyle.title,
                  ),
                ),
                Directionality(
                  textDirection: TextDirection.rtl,
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        getCardItem(
                          cardColor1,
                          'آموزشیار',
                          Icons.school_outlined,
                          'button1',
                          context,
                          cardHeight,
                          cardWidth,
                        ),
                        getCardItem(
                          cardColor2,
                          'درباره دانشگاه',
                          EvaIcons.homeOutline,
                          'button2',
                          context,
                          cardHeight,
                          cardWidth,
                        ),

                        getCardItem(
                          cardColor3,
                          'ثبت نام',
                          EvaIcons.logInOutline,
                          'button3',
                          context,
                          cardHeight,
                          cardWidth,
                        ),
                        getCardItem(
                          cardColor9,
                          'سامانه وادانا',
                          Icons.business_center_outlined,
                          'button4',
                          context,
                          cardHeight,
                          cardWidth,
                        ),
                        getCardItem(
                          cardColor5,
                          'سامانه فیش حقوقی',
                          Icons.monetization_on_outlined,
                          'button5',
                          context,
                          cardHeight,
                          cardWidth,
                        ),
                        getCardItem(
                          cardColor6,
                          'تماس با دانشگاه',
                          Icons.call_outlined,
                          'button6',
                          context,
                          cardHeight,
                          cardWidth,
                        ),
                        getCardItem(
                          cardColor7,
                          'ایمیل اساتید',
                          Icons.alternate_email_outlined,
                          'button7',
                          context,
                          cardHeight,
                          cardWidth,
                        ),
                        getCardItem(
                          cardColor8,
                          'انتخاب واحد',
                          Icons.pinch_outlined,
                          'button8',
                          context,
                          cardHeight,
                          cardWidth,
                        ),
                        // ... دیگر ویجت‌ها
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
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
                            Text(
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
                    separatorBuilder: (context, index) => SizedBox(
                        height: 16), // افزودن یک فاصله 16 پیکسل بین هر آیتم
                    itemBuilder: (context, index) {
                      var tasks = box.values.toList()[index];
                      return TaskWidget(task: tasks);
                    },
                    itemCount: box.values.length,
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget getCardItem(
    Color Card_Color,
    String CardName,
    IconData CardIcon,
    String cardKey,
    BuildContext context,
    double cardHeight,
    double cardWidth,
  ) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Container(
          height: cardHeight,
          width: cardWidth,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: Card_Color,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 5,
                blurRadius: 7,
                offset: Offset(0, 3),
              ),
            ],
          ),
          child: LayoutBuilder(builder: (context, constraints) {
            return Stack(
              children: [
                Positioned(
                  bottom: constraints.maxHeight * .6,
                  left: -constraints.maxWidth * .1,
                  right: -constraints.maxWidth * .1,
                  child: Icon(
                    CardIcon,
                    color: Colors.white.withOpacity(0.5),
                    size: 100,
                  ),
                ),
                Positioned(
                  bottom: constraints.maxHeight * .4,
                  left: -constraints.maxWidth * .1,
                  right: -constraints.maxWidth * .1,
                  child: Icon(
                    CardIcon,
                    color: Colors.white,
                    size: 30,
                  ),
                ),
                Positioned(
                  top: constraints.maxHeight * .56,
                  left: -constraints.maxWidth * .1,
                  right: -constraints.maxWidth * .1,
                  child: Padding(
                    padding: const EdgeInsets.all(25.0),
                    child: ElevatedButton(
                      onPressed: () {
                        checkInternetAndNavigate(context, cardKey);
                      },
                      child: Text(
                        CardName,
                        style: CustomTextStyle.headline25,
                      ),
                    ),
                  ),
                ),
              ],
            );
          }),
        ),
      ),
    );
  }
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
      SnackBar(
        content: Text('اتصال به اینترنت وجود ندارد.'),
        duration: Duration(seconds: 3),
      ),
    );
  }
}

void navigateToUrl(BuildContext context, String cardKey) async {
  final Object urlObject = getCorrespondingUrl(context, cardKey);

  if (urlObject is Uri) {
    await launchUrl(urlObject, mode: LaunchMode.platformDefault);
  }
}

Object getCorrespondingUrl(BuildContext context, String cardKey) {
  if (cardKey == 'button1') {
    return Uri.parse('https://stdn.iau.ir/Student/Pages/acmstd/loginPage.jsp');
  } else if (cardKey == 'button2') {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => AboutUniversityPage()),
    );
  } else if (cardKey == 'button3') {
    return Uri.parse('https://www.example.org');
  }
  return '';
}

class AboutUniversityPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('درباره دانشگاه'),
      ),
      body: Center(
        child: Text('این صفحه مربوط به دانشگاه است.'),
      ),
    );
  }
}

class SecondPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Second Page'),
      ),
      body: Center(
        child: Text('This is the second page.'),
      ),
    );
  }
}
