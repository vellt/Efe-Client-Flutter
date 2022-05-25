import 'dart:async';
import 'package:get/get.dart';
import 'package:uk_vocabulary_builder_flutter/utils/networking.dart';
import 'package:uk_vocabulary_builder_flutter/model/lesson.dart';
import 'package:uk_vocabulary_builder_flutter/model/audio.dart';

class ApiLessonController extends GetxController {
  String lessonRoute = "";

  @override
  Future onInit() async {
    super.onInit();
    //lehivja a hálózatrol a nyers json állományt
    print(lessonRoute);
    NetworkHelper networkHelper = NetworkHelper(Uri.parse(lessonRoute));
    print(lessonRoute);
    _data = await networkHelper.getData();
    if (_data != null)
      _lesson.value =
          openLesson(_lessonUniqueIndex); //beállítjuk a lesson adatát
  }

  var _data; //a nyers json anyag
  int _index = 0;
  String _lessonUniqueIndex = "1.1";
  final _lesson = Rxn<Lesson>(); //current lesson

  Lesson get getLesson => _lesson.value ?? Lesson.empty(); //current lesson

  bool get isFetchingSuccess =>
      _data != null; //hiztos hogy jött adat a szerverről

  //Betölti a lesson-t argumentumban megadott egyedi azonosito alapján
  Lesson openLesson(String lessonUniqueIndex) {
    if (getLessonIDs().contains(lessonUniqueIndex)) {
      _index = getLessonIDs().indexOf(lessonUniqueIndex);
      _lessonUniqueIndex = lessonUniqueIndex;
      _lesson.value = _getLessonByUniqueIndex(key: _lessonUniqueIndex);
    }
    update();
    return _lesson.value!;
  }

  //következő lecke betöltése
  Lesson? nextLesson() {
    if ((_index + 1) != getLessonIDs().length) {
      _lesson.value = _getLessonByUniqueIndex(key: getLessonIDs()[++_index]);
    }
    update();
    return _lesson.value;
  }

  //előző lecke betöltése
  Lesson? backLesson() {
    if ((_index - 1) != -1) {
      _lesson.value = _getLessonByUniqueIndex(key: getLessonIDs()[--_index]);
    }
    return _lesson.value;
  }

  //lehivja az osszes lecke azonositojat
  List<String> getLessonIDs() {
    List<String> lessonIDs = [];
    if (_data != null) {
      for (var item in _data["ref"]["documents"]) {
        for (var i = 0; i < item["data"]["exercises"].length; i++) {
          lessonIDs.add("${item["data"]["index"]}.${i + 1}");
        }
      }
    }
    print("lesson ids length: ${lessonIDs.length}");
    return lessonIDs;
  }

  //az aktulis lesson adatot lehivja a könyv egyedi indexe alapján
  Lesson _getLessonByUniqueIndex({required String key}) {
    if (_data != null) {
      int firstIndex = int.parse(key.split('.')[0]) - 1;
      int secondIndex = int.parse(key.split('.')[1]) - 1;
      String title = _data["ref"]["documents"][firstIndex]["data"]["exercises"]
              [secondIndex]["customTitle"] ??
          _data["ref"]["documents"][firstIndex]["data"]["title"];
      print(title);
      _lessonUniqueIndex = key;
      _lesson.value = Lesson(
        id: key,
        title: title.split("-")[0],
        subtitle:
            title.split("-").length == 2 ? title.split("-")[1].trim() : null,
        audios: _getAudioData(_data["ref"]["documents"][firstIndex]["data"]
            ["exercises"][secondIndex]["audio"]),
      );
    }
    return _lesson.value!;
  }

  List<Audio> _getAudioData(var audios) {
    List<Audio> temp = [];
    for (var audio in audios) {
      temp.add(Audio(
        title: (audio["text"] ?? audio["number"] ?? "").toString(),
        voiceUrl: '${audio["filepath"]}${audio["filename"]}',
        isFavorite: false,
      ));
    }
    return temp;
  }

  List<String> getAudioSources() {
    List<String> temp = [];
    for (var audio in getLesson.audios) {
      temp.add(audio.voiceUrl);
    }
    return temp;
  }
}
