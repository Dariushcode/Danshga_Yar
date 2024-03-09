import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class YourPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final List<CardInfo> cards = [
      CardInfo(' کانال افق', Icons.send, 'button1', 't1.jpg', Colors.blue),
      CardInfo('روابط عمومی و اطلاع‌رسانی ', Icons.send, 'button2', 't2.jpg',
          Colors.blue),
      CardInfo('چت یادگار', Icons.send, 'button3', 't3.jpg', Colors.blue),
      CardInfo(
          'بات کامپیوتر یادگار', Icons.send, 'button4', 't4.jpg', Colors.blue),
      CardInfo(
          'همکلاسی یاب یادگار', Icons.send, 'button5', 't5.jpg', Colors.blue),
      CardInfo('فقط کامپیوتر (یادگار)', Icons.send, 'button6', 't6.jpg',
          Colors.blue),
      CardInfo(
          'فقط کامپیوتر (آیگپ)', Icons.sms, 'button7', 't7.jpg', Colors.green),
      CardInfo('فقط کامپیوتر (آیگپ)', Icons.sms_rounded, 'button8', 't8.jpg',
          Colors.green),
      // ادامه تعریف کارت‌ها
    ];

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('کانال ها و گروه ها'),
      ),
      body: CustomScrollView(
        slivers: [
          SliverGrid(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2, // تعداد کل ستون‌ها
              crossAxisSpacing: 10.0, // فاصله بین ستون‌ها
              mainAxisSpacing: 10.0, // فاصله بین ردیف‌ها
            ),
            delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) {
                return getCardItem(cards[index], context, 150, 150);
              },
              childCount: cards.length,
            ),
          ),
        ],
      ),
    );
  }

  Widget getCardItem(CardInfo card, BuildContext context, double cardHeight,
      double cardWidth) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Container(
          height: cardHeight,
          width: cardWidth,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: card.cardcolor, // یا هر رنگ دیگری که دلتان بخواهد
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
                  bottom: constraints.maxHeight * .6,
                  left: -constraints.maxWidth * .1,
                  right: -constraints.maxWidth * .1,
                  child: Icon(
                    card.icon,
                    color: Colors.white.withOpacity(0.5),
                    size: 100,
                  ),
                ),
                Positioned(
                  bottom: constraints.maxHeight * .4,
                  right: 20,
                  left: 20,
                  child: ClipOval(
                    child: Container(
                      height: 70,
                      width: 70,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                      ),
                      child: Image(
                          image: AssetImage('images/${card.profileImage}'),
                          fit: BoxFit.fill),
                    ),
                  ),
                ),
                Positioned(
                  top: constraints.maxHeight * .50,
                  left: -constraints.maxWidth * .1,
                  right: -constraints.maxWidth * .1,
                  child: Padding(
                    padding: const EdgeInsets.all(25.0),
                    child: ElevatedButton(
                      onPressed: () {
                        checkInternetAndNavigate(context, card.key);
                      },
                      child: Text(
                        card.title,
                        textAlign: TextAlign.center,
                        style: const TextStyle(fontSize: 13),
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

class CardInfo {
  final String title;
  final IconData icon;
  final String key;
  String profileImage;
  Color cardcolor;

  CardInfo(this.title, this.icon, this.key, this.profileImage, this.cardcolor);
}

Future<bool> checkInternetConnection() async {
  var connectivityResult = await Connectivity().checkConnectivity();
  return connectivityResult != ConnectivityResult.none;
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

void navigateToUrl(BuildContext context, String cardKey) {
  final Object urlObject = getCorrespondingUrl(context, cardKey);

  if (urlObject is Uri) {
    launchUrl(urlObject, mode: LaunchMode.externalApplication);
  }
}

Object getCorrespondingUrl(BuildContext context, String cardKey) {
  switch (cardKey) {
    case 'button1':
      return Uri.parse('https://t.me/OFOGH_1395');
    case 'button2':
      return Uri.parse('https://t.me/yi_iau');
    case 'button3':
      return Uri.parse('https://t.me/+-IAB12-M5shhOTc0');
    case 'button4':
      return Uri.parse('https://t.me/ofoghyar_bot');
    case 'button5':
      return Uri.parse('https://t.me/hamkelasi_yab');
    case 'button6':
      return Uri.parse('https://t.me/OnlyComputerYadegar');
    case 'button7':
      return Uri.parse('https://igap.net/ce_yadegar');
    case 'button8':
      return Uri.parse('https://igap.net/ofogh_yadegar');
    case 'button9':
      return Uri.parse(
          'https://stdn.iau.ir/Student/Pages/acmstd/loginPage.jsp');
    default:
      return ''; // برای هر کلید دیگری، لینک خالی یا هر مقدار دلخواه
  }
}
