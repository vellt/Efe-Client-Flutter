import 'package:uk_vocabulary_builder_flutter/model/audio.dart';

class Lesson {
  late String id;
  late String title;
  late String? subtitle;
  late List<Audio> audios;
  bool isEmpty = false;

  Lesson({
    required this.id,
    required this.title,
    this.subtitle,
    required this.audios,
  }) {
    isEmpty = false;
  }
  Lesson.empty() {
    isEmpty = true;
  }
}
