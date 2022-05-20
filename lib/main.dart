import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sizer/sizer.dart';
import 'package:uk_vocabulary_builder_flutter/screens/frame_screen.dart';
import 'package:uk_vocabulary_builder_flutter/utils/constants.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: Colors.white,
    statusBarIconBrightness: Brightness.dark,
  ));
  runApp(MyApp());
}

GlobalKey<FrameScreenState> frameState = GlobalKey();

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Sizer(
      builder: (context, orientation, deviceType) {
        return MaterialApp(
          title: kAppTitle,
          debugShowCheckedModeBanner: false,
          theme: kTheme,
          home: SafeArea(child: FrameScreen()),
        );
      },
    );
  }
}
