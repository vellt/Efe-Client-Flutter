import 'package:audioplayers/audioplayers.dart';
import 'package:get/get.dart';
import 'package:uk_vocabulary_builder_flutter/api/secret.dart' as secret;
import 'package:uk_vocabulary_builder_flutter/utils/duration_extensions.dart';

class PlayerController extends GetxController {
  final AudioPlayer _advancedPlayer = AudioPlayer();
  Rx<Duration> duration = Duration(seconds: 0).obs;
  Rx<Duration> position = Duration(seconds: 0).obs;
  Rx<PlayerState> playState = PlayerState.STOPPED.obs;

  final Rx<int> currentAudioIndex = 0.obs;
  final Rx<int> tempAudioIndex = 0.obs;
  final Rx<bool> thePlayerIsInPreviewMode = false.obs;
  final Rx<int> currentLessonIndex = 0.obs;

  List<String> audioSources = <String>[];

  PlayerController({required int currentLessonIndex}) {
    this.currentLessonIndex.value = currentLessonIndex;
  }

  Rx<bool> get isPlaying => (playState.value == PlayerState.PLAYING).obs;

  @override
  void onInit() {
    super.onInit();

    _advancedPlayer.onDurationChanged.listen((d) {
      duration.value = d;
    });

    _advancedPlayer.onAudioPositionChanged.listen((p) {
      position.value = p;
    });

    _advancedPlayer.onPlayerStateChanged.listen((PlayerState state) {
      playState.value = state;
    });

    _advancedPlayer.onPlayerCompletion.listen((event) {
      position.value = duration.value;
    });

    ever(currentAudioIndex,
        (_) => print("currentAudioIndex: ${currentAudioIndex.value}"));
    ever(tempAudioIndex,
        (_) => print("tempAudioIndex: ${tempAudioIndex.value}"));
    ever(
        thePlayerIsInPreviewMode,
        (_) => print(
            "thePlayerIsInPreviewMode: ${thePlayerIsInPreviewMode.value}"));
    ever(currentLessonIndex,
        (_) => print("currentLessonIndex: ${currentLessonIndex.value}"));
  }

  @override
  void onClose() {
    _advancedPlayer.dispose();
    super.onClose();
  }

  //gorgetni lehet a hangban lejatszas kozben
  set setPositionValue(double value) =>
      _advancedPlayer.seek(Duration(seconds: value.toInt()));

  //resume or pause
  void resumeOrPause() async {
    (playState.value == PlayerState.PLAYING) ? pause() : resume();
  }

  //play from the 0 second
  void play(int index, {required int of}) async {
    //maybePlayedAudioIndex.value = index;
    print(
        "start: ${position.value.timeFormat} end: ${duration.value.timeFormat}");
    currentAudioIndex.value = index;
    tempAudioIndex.value = index;
    currentLessonIndex.value = of;
    stop();
    resume();
  }

  //play
  void resume() async {
    await _advancedPlayer.play(
        "${secret.assetsBaseUrl}${audioSources[currentAudioIndex.value]}");
  }

  //pause
  void pause() async {
    await _advancedPlayer.pause();
  }

  //stop
  void stop() async {
    int result = await _advancedPlayer.stop();
    if (result == 1) {
      position.value = Duration(seconds: 0);
    }
  }

  void next(int of) {
    if (currentAudioIndex.value + 1 != audioSources.length)
      play(++currentAudioIndex.value, of: of);
  }

  void back(int of) {
    if (currentAudioIndex.value - 1 != -1)
      play(--currentAudioIndex.value, of: of);
  }
}
