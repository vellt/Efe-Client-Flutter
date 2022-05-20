import 'package:uk_vocabulary_builder_flutter/model/audio.dart';

class Lesson {
  late String title;
  late List<Audio> audios;
  Lesson({
    required this.title,
    required this.audios,
  });
}
