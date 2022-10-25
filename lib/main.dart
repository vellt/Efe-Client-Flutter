import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:uk_vocabulary_builder_flutter/controllers/api_lesson_controller.dart';
import 'package:uk_vocabulary_builder_flutter/model/favorite.dart';
import 'package:uk_vocabulary_builder_flutter/screens/book_chooser_screen.dart';
import 'package:uk_vocabulary_builder_flutter/screens/frame_screen.dart';
import 'package:uk_vocabulary_builder_flutter/utils/constants.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'boxes/crud_box.dart';
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

  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(FavoriteAdapter());
  //megnyitjuk a boxot
  await CrudBox.openBox();

  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: Colors.transparent, // status bar color
    statusBarBrightness: Brightness.dark,
  ));

  /*SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
  ));*/
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
          home: BookChooser(),
        );
      },
    );
  }
}
