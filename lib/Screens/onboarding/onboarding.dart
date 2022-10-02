import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive/hive.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:video_thumbnail/video_thumbnail.dart';

import '../../bottom_navigation/screenhome.dart';
import '../../main.dart';
import '../../model/model.dart';
import 'widgets.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({Key? key}) : super(key: key);

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  final List<String> _pathList = [];
  List thumbs = [];
  var boxVideos = Hive.box<Videos>(videoBox);

  final _controller = PageController();
  int _currentPage = 0;

  AnimatedContainer _buildDots({int? index}) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(
          Radius.circular(50),
        ),
        color: Color(0xFF293241),
      ),
      margin: const EdgeInsets.only(right: 5),
      height: 10,
      curve: Curves.easeIn,
      width: _currentPage == index ? 20 : 10,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Expanded(
            flex: 4,
            child: Image.asset(
              'assets/images/onboard_bg.png',
              width: MediaQuery.of(context).size.width,
              fit: BoxFit.fill,
            ),
          ),
          Expanded(
            flex: 2,
            child: PageView.builder(
              controller: _controller,
              itemCount: splashData.length,
              itemBuilder: (BuildContext context, int index) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    onBoardingImage(context, index),
                    const Spacer(),
                    onBoardingText(context, index),
                  ],
                );
              },
              onPageChanged: (value) => setState(() => _currentPage = value),
            ),
          ),
          Expanded(
              flex: 1,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(top: 20.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(
                        splashData.length,
                        (int index) => _buildDots(index: index),
                      ),
                    ),
                  ),
                  const Spacer(),
                  Padding(
                    padding: const EdgeInsets.only(right: 40,left: 40,top: 5),
                    child: SizedBox(
                      height: 59,
                      width: MediaQuery.of(context).size.width * 0.7,
                      child: onBoardButton(context),
                    ),
                  ),
                  
                  const Spacer(),
                ],
              )),
              SizedBox(height: 15,)
        
        ],
      ),
    );
  }

  Future getThumb() async {
    for (var i = 0; i < _pathList.length; i++) {
      var key = (await VideoThumbnail.thumbnailData(
        video: _pathList[i],
        imageFormat: ImageFormat.JPEG,
        maxWidth: 128,
        quality: 25,
      ));
      thumbs.add(key);
      setState(() {});

      boxVideos.put(i, Videos(paths: _pathList[i], thumb: thumbs[i], fav: false));

      // print(listBox[i]);
    }
  }

  ElevatedButton onBoardButton(BuildContext context) {
    return ElevatedButton(
      onPressed: () async {
        _currentPage + 1 == splashData.length
            ? onBoard(context)
            : _controller.nextPage(
                duration: const Duration(milliseconds: 200),
                curve: Curves.easeIn,
              );
        if (_currentPage + 1 == splashData.length) {}
      },
      style: ElevatedButton.styleFrom(
        primary: const Color(0xFF7E9FDC),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(35),
        ),
      ),
      child: Text(
        _currentPage + 1 == splashData.length ? 'Go to app' : 'Next',
        style: const TextStyle(
          fontSize: 26,
          fontFamily: "Poppins",
        ),
      ),
    );
  }

  onBoard(BuildContext ctx) async {
    // await getThumb();
    final sharedPrefs = await SharedPreferences.getInstance();
    await sharedPrefs.setBool(first_time, true);
    Navigator.of(ctx).pushReplacement(MaterialPageRoute(
        builder: (context) => ScreenHome(
              isSatrting: 'yes',
            )));
  }
}
