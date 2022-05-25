import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

//theme
final kTheme = ThemeData.light().copyWith(
  platform: TargetPlatform.iOS,
  primaryColor: kWhite,
  scaffoldBackgroundColor: kWhite,
);

//text styles
final kHomeTitleTextStyle = TextStyle(
  color: kNightGrayColor,
  fontSize: 28.sp,
  fontWeight: FontWeight.bold,
);
final kHomeSubTitleTextStyle = TextStyle(
  color: kNightGrayColor,
  fontSize: 28.sp,
  fontWeight: FontWeight.w300,
);

final kAudioPlayerTitleTextStyle = TextStyle(
  fontSize: 25.sp,
  fontWeight: FontWeight.w300,
  color: kMainDarkGrayColor,
);

final kHomeSearchTextStyle = TextStyle(
  color: kWhite,
  fontSize: 13.sp,
);
final kVoiceElementNightTextStyle = TextStyle(
  color: kNightGrayColor,
  fontWeight: FontWeight.bold,
  fontSize: 12.sp,
);

final kVoiceElementDarkTextStyle = TextStyle(
  color: kDarkGrayColor,
  fontSize: 12.sp,
);

//texts
const kHomeSearchText = "Search";
const kHomeSearchInputHintText = "0.0";
const kAppTitle = "Flutter Demo";

//colors
const kWhite = Colors.white;
const kLightGrayColor = Color(0xFFEBEBEB);
const kMiddleGrayColor = Color(0xFFD2D2D2);
const kDarkGrayColor = Color(0xFFBBBBBB);
const kNightGrayColor = Color(0xFF707070);
const kMainDarkGrayColor = Color(0xFF636363);
