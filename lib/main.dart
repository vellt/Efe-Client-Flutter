import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:uk_vocabulary_builder_flutter/controllers/api_lesson_controller.dart';
import 'package:uk_vocabulary_builder_flutter/screens/book_chooser_screen.dart';
import 'package:uk_vocabulary_builder_flutter/screens/frame_screen.dart';
import 'package:uk_vocabulary_builder_flutter/utils/constants.dart';

import 'model/lesson.dart';

void main() async {
  /*ApiLessonController apiLessonController =
      ApiLessonController("vocabulary-builder");
  await apiLessonController.onInit();
  print(apiLessonController.lessons
      .where((element) => (element.id == "2.3"))
      .first
      .audios[9]
      .title);*/

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Sizer(
      builder: (context, orientation, deviceType) {
        return GetMaterialApp(
          title: kAppTitle,
          debugShowCheckedModeBanner: false,
          theme: kTheme,
          home: SafeArea(child: BookChooser()),
        );
      },
    );
  }
}
