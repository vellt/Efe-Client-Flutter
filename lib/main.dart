import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:uk_vocabulary_builder_flutter/controllers/api_lesson_controller.dart';
import 'package:uk_vocabulary_builder_flutter/screens/book_chooser_screen.dart';
import 'package:uk_vocabulary_builder_flutter/screens/frame_screen.dart';
import 'package:uk_vocabulary_builder_flutter/utils/constants.dart';

void main() async {
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: Colors.white,
    statusBarIconBrightness: Brightness.dark,
  ));

  //ez a legelő lepes, amikoris kijóvélasztjuk milyen könyvet akarunk megnyitni, elalapján
  /* EfeController efeLessonController = EfeController();
  var elements = await efeLessonController.getBooks();
  print("----------${elements[0].route}");*/

  runApp(MyApp());
  //runApp(BookChooser());
}

//GlobalKey<FrameScreenState> frameState = GlobalKey();

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Sizer(
      builder: (context, orientation, deviceType) {
        return GetMaterialApp(
          title: kAppTitle,
          debugShowCheckedModeBanner: false,
          theme: kTheme,
          home: SafeArea(child: BookChooser()), //FrameScreen()),
        );
      },
    );
  }
}
