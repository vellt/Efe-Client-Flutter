import 'package:uk_vocabulary_builder_flutter/model/audio.dart';

class Lesson {
  late int position;
  late String id;
  late String title;
  late String? subtitle;
  late List<Audio> audios;

  Lesson({
    required this.position,
    required this.id,
    required this.title,
    this.subtitle,
    required this.audios,
  });
}
