import 'package:carousel_slider/carousel_slider.dart';
import 'package:connectivity/connectivity.dart';
import 'package:danshga_yar/pages/barbutton.dart';
import 'package:dashed_circular_progress_bar/dashed_circular_progress_bar.dart';
import 'package:flutter/material.dart';
import 'package:air_quality/air_quality.dart';

enum AppState { NOT_DOWNLOADED, DOWNLOADING, FINISHED_DOWNLOADING }

class air extends StatelessWidget {
  const air({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MyHomePage(
      title: 'کیفیت هوای امروز',
    );
  }
}

bool _isConnected = true;

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, this.title}) : super(key: key);

  final String? title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final String _key = 'c05dc21dec655a0c2c472c3a44b73d5aaeb96def';
  late AirQuality _airQuality;
  late CarouselController _carouselController;
  AppState _state = AppState.NOT_DOWNLOADED;
  late List<AirQualityData> _data;

  @override
  void initState() {
    _checkInternetConnection();
    super.initState();
    _carouselController = CarouselController();
    _airQuality = AirQuality(_key);
    download();
  }

  Future<void> _checkInternetConnection() async {
    var connectivityResult = await Connectivity().checkConnectivity();
    setState(() {
      _isConnected = connectivityResult != ConnectivityResult.none;
    });
  }

  void _retryDownload() {
    setState(() {
      _checkInternetConnection();
      download();
    });
  }

  Widget showContent() {
    if (!_isConnected) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('خطا در اتصال به اینترنت'),
            ElevatedButton(
              onPressed: _retryDownload,
              child: const Text('تلاش مجدد'),
            ),
          ],
        ),
      );
    }

    if (_state == AppState.FINISHED_DOWNLOADING) {
      return contentFinishedDownload();
    } else if (_state == AppState.DOWNLOADING) {
      return contentDownloading();
    } else {
      return contentNotDownloaded();
    }
  }

  Future<void> download() async {
    _data = [];
    setState(() {
      _state = AppState.DOWNLOADING;
    });

    AirQualityData feedFromGeoLocation = await _airQuality.feedFromGeoLocation(
      35.55857826862609,
      51.36205742493023,
    );
    AirQualityData fromcity = await _airQuality.feedFromCity(' tehran');
    AirQualityData fromIP = await _airQuality.feedFromIP();

    setState(() {
      _data.add(feedFromGeoLocation);
      _data.add(fromcity);
      _data.add(fromIP);
    });

    setState(() {
      _state = AppState.FINISHED_DOWNLOADING;
    });
  }

  Widget contentFinishedDownload() {
    return SingleChildScrollView(
      child: CarouselSlider.builder(
        carouselController: _carouselController,
        itemCount: _data.length,
        options: CarouselOptions(
          height: MediaQuery.of(context).size.height * 0.8,
          enlargeCenterPage: true,
          autoPlay: true,
          aspectRatio: 16 / 9,
          autoPlayCurve: Curves.easeInOutQuart,
          enableInfiniteScroll: true,
          autoPlayAnimationDuration: const Duration(milliseconds: 18000),
          viewportFraction: 0.8,
        ),
        itemBuilder: (BuildContext context, int index, int realIndex) {
          AirQualityData data = _data[index];

          return Card(
            margin: EdgeInsets.symmetric(
              horizontal: MediaQuery.of(context).size.height * 0.01,
              vertical: MediaQuery.of(context).size.height * 0.01,
            ),
            color: Colors.white,
            elevation: 0,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Expanded(child: _getImage(data.airQualityIndex)),
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(2.0),
                              child: Text(
                                ' ${_getloction(data.place)}',
                                style: TextStyle(),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(3.0),
                              child: Text(
                                ' ${_gethealth(data.airQualityIndex)}',
                                style: TextStyle(
                                  fontSize: MediaQuery.of(context).size.height *
                                      0.020,
                                  color: _getColor(data.airQualityIndex),
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                Expanded(
                  child: Center(
                    child: SizedBox(
                      width: MediaQuery.of(context).size.height * 0.3,
                      height: MediaQuery.of(context).size.height * 0.3,
                      child: DashedCircularProgressBar.aspectRatio(
                        aspectRatio: 1,
                        valueNotifier:
                            ValueNotifier(data.airQualityIndex.toDouble()),
                        maxProgress: 300,
                        progress: data.airQualityIndex.toDouble(),
                        startAngle: 225,
                        sweepAngle: 270,
                        foregroundColor: _getColor(data.airQualityIndex),
                        backgroundColor: const Color(0xffcccfda),
                        foregroundStrokeWidth: 15,
                        backgroundStrokeWidth: 15,
                        animation: true,
                        seekSize: 6,
                        seekColor: const Color(0xffcccfda),
                        child: Center(
                          child: ValueListenableBuilder(
                            valueListenable:
                                ValueNotifier(data.airQualityIndex.toDouble()),
                            builder: (_, double value, __) => Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  '${value.toInt()}',
                                  style: const TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w300,
                                    fontSize: 60,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                ListTile(),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    ' ${data.place}',
                    style: TextStyle(
                      fontSize: MediaQuery.of(context).size.height * 0.015,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    ' ${data.airQualityLevel}',
                    style: TextStyle(
                      fontSize: MediaQuery.of(context).size.height * 0.015,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    ' ${data.source}',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: MediaQuery.of(context).size.height * 0.015,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    ' ${_getloction(data.place)}',
                    style: TextStyle(
                      fontSize: MediaQuery.of(context).size.height * 0.015,
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _getImage(int aqi) {
    String imagePath;

    if (aqi <= 50) {
      imagePath = 'images/1.gif';
    } else if (aqi <= 100) {
      imagePath = 'images/2.gif';
    } else if (aqi <= 150) {
      imagePath = 'images/3.gif';
    } else if (aqi <= 200) {
      imagePath = 'images/4.gif';
    } else if (aqi <= 300) {
      imagePath = 'images/5.gif';
    } else {
      imagePath = 'images/6.gif';
    }

    return Image.asset(
      imagePath,
      width: 130,
      height: 130,
      fit: BoxFit.contain,
    );
  }

  Color _getColor(int aqi) {
    if (aqi <= 50) {
      return Colors.green;
    } else if (aqi <= 100) {
      return Colors.yellow;
    } else if (aqi <= 150) {
      return Colors.orange;
    } else if (aqi <= 200) {
      return Colors.red;
    } else if (aqi <= 300) {
      return Colors.purple;
    } else {
      return Colors.brown;
    }
  }

  Color _getTextColor(int aqi) {
    return aqi <= 100 ? Colors.black : Colors.white;
  }

  Icon _getIcon(int aqi) {
    IconData iconData;

    if (aqi <= 50) {
      iconData = Icons.check_circle;
    } else if (aqi <= 100) {
      iconData = Icons.info;
    } else if (aqi <= 150) {
      iconData = Icons.warning;
    } else if (aqi <= 200) {
      iconData = Icons.error;
    } else if (aqi <= 300) {
      iconData = Icons.report_problem;
    } else {
      iconData = Icons.dangerous;
    }

    return Icon(
      iconData,
      color: _getTextColor(aqi),
    );
  }

  String _gethealth(int aqi) {
    String label;

    if (aqi <= 50) {
      label = 'پاک';
    } else if (aqi <= 100) {
      label = 'قابل قبول';
    } else if (aqi <= 150) {
      label = 'ناسالم برای گروه‌های حساس';
    } else if (aqi <= 200) {
      label = 'ناسالم';
    } else if (aqi <= 300) {
      label = 'بسیار ناسالم';
    } else {
      label = 'خطرناک';
    }

    return label;
  }

  String _getloction(String place) {
    String label;

    if (place.contains('باقرشهر')) {
      label = 'دانشگاه یادگار امام ';
    } else if (place.contains('تهران')) {
      label = 'تهران  ';
    } else {
      label = 'My location ';
    }

    return label;
  }

  Widget contentDownloading() {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircularProgressIndicator(
            strokeWidth: 6,
          ),
          SizedBox(height: 16),
          Text('...درحال دریافت اطلاعات'),
        ],
      ),
    );
  }

  Widget contentNotDownloaded() {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('Press the button to download the Air Quality'),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white.withOpacity(.88),
      bottomNavigationBar: BarButton(),
      appBar: AppBar(
        centerTitle: true,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(widget.title!),
            const Icon(Icons.air_outlined),
          ],
        ),
      ),
      body: showContent(),
    );
  }
}
