import 'dart:async';
import 'package:get/get.dart';
import 'package:uk_vocabulary_builder_flutter/utils/networking.dart';
import 'package:uk_vocabulary_builder_flutter/model/lesson.dart';
import 'package:uk_vocabulary_builder_flutter/model/audio.dart';

class ApiLessonController extends GetxController {
  Rx<int> selectedLessonIndex = 0.obs;
  final List<Lesson> lessons = [];
  String _lessonRoute = "";

  ApiLessonController(String routeNameOfLesson) {
    _lessonRoute = routeNameOfLesson;
  }

  @override
  Future onInit() async {
    super.onInit();
    NetworkHelper networkHelper = NetworkHelper(Uri.parse(_lessonRoute));
    var _data = await networkHelper.getData();
    if (_data != null) {
      int index = 0;
      for (var item in _data["ref"]["documents"]) {
        for (var lesson in item["data"]["exercises"]) {
          String id = "${item["data"]["index"]}.${lesson["index"]}";
          String title = lesson["customTitle"] ?? item["data"]["title"];
          String mainTitle = title.split("-")[0];
          String? subtitle =
              title.split("-").length == 2 ? title.split("-")[1].trim() : null;
          List<Audio> audios = [];
          for (var audio in lesson["audio"]) {
            String title = (audio["text"] ?? audio["number"] ?? "").toString();
            String voiceUrl = '${audio["filepath"]}${audio["filename"]}';
            audios.add(
                Audio(title: title, voiceUrl: voiceUrl, isFavorite: false));
          }

          lessons.add(
            Lesson(
              position: index++,
              title: mainTitle,
              id: id,
              audios: audios,
              subtitle: subtitle,
            ),
          );
        }
      }
    }

    ever(
        selectedLessonIndex,
        (_) => print(
            "$_ has been changed: ${selectedLesson.title}\n${selectedLesson.audios.length}"));
  }

  //aktuális lecke
  Lesson get selectedLesson => lessons[selectedLessonIndex.value];

  //következő lecke betöltése
  int nextLesson() {
    if ((selectedLessonIndex.value + 1) != lessons.length) {
      selectedLessonIndex.value++;
    }
    return selectedLessonIndex.value;
  }

  //előző lecke betöltése
  int backLesson() {
    if ((selectedLessonIndex.value - 1) != -1) {
      selectedLessonIndex.value--;
    }
    return selectedLessonIndex.value;
  }

  //megnyit egy uj lecket
  int openLesson(String id) {
    var match = lessons.where((element) => element.id == id);
    if (match.length != 0) {
      selectedLessonIndex.value = match.map((e) => e.position).first;
    }
    return selectedLessonIndex.value;
  }

  List<String> getUrlSourceOfAudios() {
    return lessons
        .where((element) => (element.id == selectedLesson.id))
        .first
        .audios
        .map((e) => e.voiceUrl)
        .toList();
  }

  List<Audio> getAudioDataOfSelectedLesson() {
    return lessons
        .where((element) => element.id == selectedLesson.id)
        .first
        .audios;
  }
}
