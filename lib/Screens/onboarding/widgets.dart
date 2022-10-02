import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

final List<Map<String, String>> splashData = [
  {
    "title": "One Stop Solution for your\nMultimedia Play",
    "image": "assets/images/onboard_one.png"
  },
  {
    "title": "Wolcome to the world of\nEverytainment",
    "image": "assets/images/onboard_three.png"
  },
  {
    "title": "One Stop Solution for your\nMultimedia Play",
    "image": "assets/images/onboard_two.png"
  },
  // {
  //   "title": "Thank u for your patience\nPlease Wait ",
  //   "image": "assets/images/onboard_three.png"
  // },

  // {

  //   "title":
  //       "Do your best in your day to day life\nand unlock achievements",
  //   "image": "assets/images/boarding3.png"
  // },
];

SizedBox onBoardingImage(BuildContext context, int index) {
  return SizedBox(
    height: MediaQuery.of(context).size.height * .18,
    width: MediaQuery.of(context).size.width * .6,
    child: AspectRatio(
      aspectRatio: 9 / 16,
      child: Image.asset(
        splashData[index]['image']!,
        fit: BoxFit.cover,
      ),
    ),
  );
}

Text onBoardingText(BuildContext context, int index) {
  return Text(
    splashData[index]['title']!,
    textAlign: TextAlign.center,
    style: TextStyle(
      fontFamily: "Poppins",
      fontSize: 16.sp,
      color: const Color.fromARGB(255, 37, 37, 37),
      height: 1.5,
    ),
  );
}
