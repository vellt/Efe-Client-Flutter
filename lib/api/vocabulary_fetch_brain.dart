import 'package:uk_vocabulary_builder_flutter/model/audio.dart';
import 'package:uk_vocabulary_builder_flutter/model/exercise.dart';
import 'networking.dart';
import 'package:uk_vocabulary_builder_flutter/api/secret.dart' as secret;

//peldanyositayst kovetoebn be lesz olvasva a legutobb elmenetett adat
//inicializaciot kovetoen, már van inexem, tudom az adatokat lekrrni!
class VocabularyFetchBrain {
  var _data;
  String _lessonID = "";
  late int _index;
  Lesson? _currentLesson;

  VocabularyFetchBrain({required String currentLessonID}) {
    _lessonID = currentLessonID;
  }

  //az indexet kiszaolja, az aktulais lessont betolltuiui
  Future<bool> initialization() async {
    NetworkHelper networkHelper = NetworkHelper(Uri.parse(secret.ApiUrl));
    _data = await networkHelper.getData();
    if (_data != null) {
      _index = getLessonIDs().indexOf(_lessonID);
      goToLesson(_lessonID);
    }
    return _data != null ? true : false;
  }

  Lesson? getCurrentLessonData() {
    return _currentLesson;
  }

  //az aktulais lecke szamot adja vissza
  String getCurrentLessonID() {
    return _lessonID;
  }

  //leptet elore
  bool nextLesson() {
    bool condition = (_index + 1) != getLessonIDs().length;
    if (condition) {
      _lessonID = getLessonIDs()[++_index];
      _currentLesson = _getLessonByID(key: _lessonID);
    }
    return condition;
  }

  //leptet vussza
  bool previousLesson() {
    bool condition = (_index - 1) != -1;
    if (condition) {
      _lessonID = getLessonIDs()[--_index];
      _currentLesson = _getLessonByID(key: _lessonID);
    }
    return condition;
  }

  //konkretan beirja
  bool goToLesson(String lessonID) {
    bool condition = getLessonIDs().contains(lessonID);
    if (condition) {
      _index = getLessonIDs().indexOf(lessonID);
      _lessonID = lessonID;
      _currentLesson = _getLessonByID(key: _lessonID);
    }
    return condition;
  }

  //lehivja az osszes lecke azonositojat
  List<String> getLessonIDs() {
    List<String> lectures = [];
    if (_data != null) {
      for (var item in _data["ref"]["documents"]) {
        for (var i = 0; i < item["data"]["exercises"].length; i++) {
          lectures.add("${item["data"]["index"]}.${i + 1}");
        }
      }
    }
    return lectures;
  }

  //az aktulis lesson adatot lehivja
  Lesson? _getLessonByID({required String key}) {
    Lesson? exercise;
    if (_data != null) {
      int firstIndex = int.parse(key.split('.')[0]) - 1;
      int secondIndex = int.parse(key.split('.')[1]) - 1;
      print(firstIndex);
      print(secondIndex);
      String title = _data["ref"]["documents"][firstIndex]["data"]["exercises"]
              [secondIndex]["customTitle"] ??
          _data["ref"]["documents"][firstIndex]["data"]["title"];
      exercise = Lesson(
        title: title,
        audios: _getAudios(_data["ref"]["documents"][firstIndex]["data"]
            ["exercises"][secondIndex]["audio"]),
      );
    }
    return exercise;
  }

  List<Audio> _getAudios(var audios) {
    List<Audio> temp = [];
    for (var audio in audios) {
      temp.add(Audio(
        title: (audio["number"] ?? audio["text"] ?? "").toString(),
        voiceUrl: '${secret.assetsUrl}${audio["filepath"]}${audio["filename"]}',
        isFavorite: false,
      ));
    }
    return temp;
  }

  void saveTheCurrentLectureOnTheDevice(String index) {}
}
