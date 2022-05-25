import 'package:audioplayers/audioplayers.dart';
import 'package:get/get.dart';
import 'package:uk_vocabulary_builder_flutter/api/secret.dart' as secret;
import 'package:uk_vocabulary_builder_flutter/utils/duration_extensions.dart';

class PlayerController extends GetxController {
  final AudioPlayer _advancedPlayer = AudioPlayer();
  Rx<Duration> duration = Duration(seconds: 0).obs;
  Rx<Duration> position = Duration(seconds: 0).obs;
  Rx<PlayerState> playState = PlayerState.STOPPED.obs;

  final Rx<int> currentPlayedAudioIndex = 0.obs;
  List<String> audioSources = <String>[];

  Rx<bool> get isPlaying => (playState.value == PlayerState.PLAYING).obs;

  @override
  void onInit() {
    super.onInit();

    _advancedPlayer.onDurationChanged.listen((d) {
      print("aktuélis duratció: ${d}");
      duration.value = d;
    });

    _advancedPlayer.onAudioPositionChanged.listen((p) {
      print("aktuélis pozicoo: ${p}");
      position.value = p;
    });

    _advancedPlayer.onPlayerStateChanged.listen((PlayerState state) {
      playState.value = state;
    });

    _advancedPlayer.onPlayerCompletion.listen((event) {
      position.value = duration.value;
    });
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
  void play(int index) async {
    print(
        "start: ${position.value.timeFormat} end: ${duration.value.timeFormat}");
    currentPlayedAudioIndex.value = index;
    stop();
    resume();
  }

  //play
  void resume() async {
    await _advancedPlayer.play(
        "${secret.assetsBaseUrl}${audioSources[currentPlayedAudioIndex.value]}");
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

  void next() {
    if (currentPlayedAudioIndex.value + 1 != audioSources.length)
      play(++currentPlayedAudioIndex.value);
  }

  void back() {
    if (currentPlayedAudioIndex.value - 1 != -1)
      play(--currentPlayedAudioIndex.value);
  }
}
