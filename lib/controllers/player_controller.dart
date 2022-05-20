import 'package:audioplayers/audioplayers.dart';
import 'package:get/get.dart';
import 'package:uk_vocabulary_builder_flutter/model/audio.dart';
import 'package:uk_vocabulary_builder_flutter/api/secret.dart' as secret;

class PlayerController extends GetxController {
  AudioPlayer _advancedPlayer = AudioPlayer();
  Duration duration = Duration(seconds: 0);
  Duration position = Duration(seconds: 0);
  PlayerState playState = PlayerState.STOPPED;

  int currentAudioIndex = 0;
  var playlist = <Audio>[];
  PlayerController({required this.playlist});

  @override
  void onInit() {
    super.onInit();

    _advancedPlayer.onDurationChanged.listen((d) {
      duration = d;
      update();
    });

    _advancedPlayer.onAudioPositionChanged.listen((p) {
      position = p;
      update();
    });

    _advancedPlayer.onPlayerStateChanged.listen((PlayerState state) {
      playState = state;
      update();
    });

    _advancedPlayer.onPlayerCompletion.listen((event) {
      position = duration;
      update();
    });
  }

  @override
  void onClose() {
    _advancedPlayer.dispose();
    super.onClose();
  }

  //resume or pause
  void resumeOrPause() async {
    (playState == PlayerState.PLAYING) ? pause() : resume();
  }

  //play from the 0 second
  void play() async {
    stop();
    resume();
  }

  //play
  void resume() async {
    await _advancedPlayer
        .play("${secret.assetsUrl}${playlist[currentAudioIndex].voiceUrl}");
  }

  //pause
  void pause() async {
    await _advancedPlayer.pause();
  }

  //stop
  void stop() async {
    int result = await _advancedPlayer.stop();
    if (result == 1) {
      position = Duration(seconds: 0);
    }
  }

  void next() {
    if (currentAudioIndex + 1 != playlist.length) currentAudioIndex++;
    play();
  }

  void back() {
    if (currentAudioIndex - 1 != -1) currentAudioIndex--;
    play();
  }

  set setPositionValue(double value) =>
      _advancedPlayer.seek(Duration(seconds: value.toInt()));
}
