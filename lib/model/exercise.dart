import 'package:uk_vocabulary_builder_flutter/model/audio.dart';

class Lesson {
  late String title;
  late String? subtitle;
  late List<Audio> audios;
  Lesson({
    required this.title,
    this.subtitle,
    required this.audios,
  });
}
