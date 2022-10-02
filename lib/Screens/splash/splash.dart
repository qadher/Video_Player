import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../bottom_navigation/screenhome.dart';
import '../../main.dart';
import '../onboarding/onboarding.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>{
  @override
  void initState() {
    checkFirst();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(242, 237, 241, 250),
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                'assets/images/logoT.png',
                width: 250,
              ),
              const SizedBox(
                height: 100,
              ),
             const CircularProgressIndicator(
                semanticsLabel: 'linear progress indicator',
                color:  Color.fromARGB(255, 152, 157, 189),
              ),
            ],
          ),
        ),
      ),
    );
  }
  Future<void> gotoBoarding() async {
    await Future.delayed(const Duration(seconds: 2));
    Navigator.of(context)
        .pushReplacement(MaterialPageRoute(builder: (ctx) =>const OnBoardingScreen()));
  }
  Future<void> checkFirst() async{
    final _sharedPreferences = await SharedPreferences.getInstance();
    final _finishBoarding = _sharedPreferences.getBool(first_time);
    if (_finishBoarding == null || !_finishBoarding) {
      gotoBoarding();
    } 
    else {
      await Future.delayed(const Duration(seconds: 2));
      Navigator.of(context)
          .pushReplacement(MaterialPageRoute(builder: (ctx1) => ScreenHome(isSatrting: 'yes',)));
    }
  }
}
