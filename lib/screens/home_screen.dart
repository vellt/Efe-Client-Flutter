import 'dart:async';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:uk_vocabulary_builder_flutter/api/data_fetcher.dart';
import 'package:uk_vocabulary_builder_flutter/controllers/player_controller.dart';
import 'package:uk_vocabulary_builder_flutter/utils/constants.dart';
import 'package:uk_vocabulary_builder_flutter/widgets/home_appbar_content.dart';
import 'package:uk_vocabulary_builder_flutter/widgets/voice_element.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late DataFetcher brain;

  late AudioPlayer audioPlayer;
  late AudioCache audioCache;
  Duration _duration = Duration();
  Duration _position = Duration();

  late List<VoiceElement> voices;
  bool? initOfVocabularyBrain;

  int? activeVoice;

  bool isPlayed = true;

  String currentVoiceURL = "";

  void initData() async {
    audioPlayer = AudioPlayer();
    //get saved lesson:
    brain = DataFetcher(currentLessonID: "1.1");
    bool result = await brain.initialization();
    setState(() {
      initOfVocabularyBrain = result;
    });
  }

  void loadAudioContentFromData() {
    if (initOfVocabularyBrain != null) {
      voices = [];
      for (var i = 0; i < brain.getCurrentLessonData()!.audios.length; i++) {
        voices.add(VoiceElement(
          title: brain.getCurrentLessonData()!.audios[i].title,
          voiceUrl: brain.getCurrentLessonData()!.audios[i].voiceUrl,
          isActive: (activeVoice == i),
          isPlaying: (activeVoice == i &&
              _position != Duration(seconds: 0) &&
              isPlayed == false),
          isLoading: (activeVoice == i &&
              _position == Duration(seconds: 0) &&
              isPlayed == false),
          onPressed: (String voice) {
            _position = Duration(seconds: 0);
            currentVoiceURL = voice;
            stopOrStartPlaying(!true);
            audioPlayer.onAudioPositionChanged.listen((event) => setState(() {
                  _position = event;
                }));
            audioPlayer.onPlayerCompletion.listen((_) => setState(() {
                  isPlayed = true;
                }));

            audioPlayer.onDurationChanged.listen((event) => setState(() {
                  _duration = event;
                }));

            activeVoice = i;
            widgetVisibilityChange(true);
          },
        ));
      }
    }
  }

  Future<dynamic> showErrorDialog(String text) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Input Error"),
          content: Text("The $text isn't in the book"),
          actions: [
            TextButton(
              child: Text("OK"),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ],
        );
      },
    );
  }

  format(Duration d) {
    String minute =
        int.parse(d.toString().split('.').first.padLeft(8, "0").split(':')[1])
            .toString();
    String second = d.toString().split('.').first.padLeft(8, "0").split(':')[2];
    return ("$minute:$second");
  }

  void seekToSecond(int second) {
    Duration newDuration = Duration(seconds: second);
    audioPlayer.seek(newDuration);
  }

  void stopPlaying() {
    audioPlayer.stop();
    setState(() {
      _position = Duration(seconds: 0);
      isPlayed = true;
    });
  }

  void stopOrStartPlaying(bool condition) async {
    if (!condition) {
      int result = await audioPlayer.play(currentVoiceURL);
      if (result == 1) {
        //success
        print("folytatas");
        setState(() {
          isPlayed = false;
        });
      }
    } else {
      audioPlayer.pause();
      print("megallit");
      setState(() {
        isPlayed = true;
      });
    }
  }

  bool visible = false;

  void widgetVisibilityChange(bool visibleData) {
    setState(() {
      visible = visibleData;
      print(">>>>>>>>>>>>>>>$visible");
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initData();
    Timer(Duration(seconds: 0), () {
      setState(() {
        heightValue = 10.h;
      });
    });
  }

  double heightValue = 0;

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    loadAudioContentFromData();
    return (initOfVocabularyBrain == null)
        ? Center(
            child: CircularProgressIndicator(
              color: kMainDarkGrayColor,
            ),
          )
        : (initOfVocabularyBrain == false)
            ? Align(
                alignment: Alignment.center,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Internet lost!"),
                    IconButton(
                      onPressed: () {
                        setState(() {
                          initData();
                        });
                      },
                      icon: Icon(CupertinoIcons.refresh),
                    )
                  ],
                ),
              )
            : Scaffold(
                appBar: AppBar(
                  bottom: PreferredSize(
                    preferredSize: Size.fromHeight(6.h),
                    child: HomeAppBarContent(
                      currentValue: brain.getCurrentLessonID(),
                      onSubmitted: (String text) {
                        setState(() {
                          activeVoice = null;
                          if (!brain.goToLesson(text)) {
                            showErrorDialog(text);
                          }
                        });
                      },
                      backOnPressed: () {
                        setState(() {
                          activeVoice = null;
                          brain.previousLesson();
                        });
                      },
                      nextOnPressed: () {
                        setState(() {
                          activeVoice = null;
                          brain.nextLesson();
                        });
                      },
                    ),
                  ),
                ),
                body: GetX<PlayerController>(
                    init: PlayerController(playlist: []),
                    builder: (controller) {
                      return Column(
                        children: [
                          Expanded(
                            child: Padding(
                              padding: EdgeInsets.symmetric(horizontal: 8.w),
                              child: SingleChildScrollView(
                                child: Padding(
                                  padding: EdgeInsets.symmetric(vertical: 5.h),
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.only(bottom: 3.h),
                                        child: Align(
                                          alignment: Alignment.topLeft,
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                brain
                                                    .getCurrentLessonData()!
                                                    .title,
                                                style: kHomeTitleTextStyle,
                                              ),
                                              if (brain
                                                      .getCurrentLessonData()!
                                                      .subtitle !=
                                                  null)
                                                Text(
                                                    brain
                                                        .getCurrentLessonData()!
                                                        .subtitle!,
                                                    style:
                                                        kHomeSubTitleTextStyle),
                                            ],
                                          ),
                                        ),
                                      ),
                                      Padding(
                                          padding: EdgeInsets.only(bottom: 3.h),
                                          child: (voices.length == 0)
                                              ? Icon(
                                                  CupertinoIcons.speaker_slash,
                                                  size: 30.h,
                                                  color: kMiddleGrayColor,
                                                )
                                              : Align(
                                                  alignment: Alignment.topLeft,
                                                  child: Wrap(
                                                    spacing: 7.w,
                                                    runSpacing: 7.w,
                                                    children: voices,
                                                  ),
                                                )),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                          if (visible)
                            AnimatedContainer(
                              decoration: BoxDecoration(
                                  border: Border.all(color: Color(0xFFEFEFEF))),
                              height: heightValue,
                              duration: Duration(milliseconds: 300),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  IconButton(
                                    onPressed: () {
                                      stopOrStartPlaying(
                                          _position != Duration(seconds: 0) &&
                                              isPlayed == false);
                                    },
                                    icon: Icon(
                                        (_position != Duration(seconds: 0) &&
                                                isPlayed == false)
                                            ? Icons.pause
                                            : Icons.play_arrow),
                                    iconSize: 25.sp,
                                    color: Color(0xFF9A9A9A),
                                  ),
                                  Text(format(_position),
                                      style: TextStyle(
                                          fontSize: 13.sp,
                                          color: Color(0xFFBBBBBB))),
                                  Slider(
                                      activeColor: kMainDarkGrayColor,
                                      inactiveColor: Color(0xFFEFEFEF),
                                      value: _position.inSeconds.toDouble(),
                                      min: 0.0,
                                      max: _duration.inSeconds.toDouble(),
                                      onChanged: (double value) {
                                        setState(() {
                                          seekToSecond(value.toInt());
                                          value = value;
                                        });
                                      }),
                                  Text(
                                    format(_duration),
                                    style: TextStyle(
                                        fontSize: 13.sp,
                                        color: Color(0xFFBBBBBB)),
                                  ),
                                  IconButton(
                                    onPressed: () {
                                      stopPlaying();
                                      widgetVisibilityChange(false);
                                    },
                                    icon: Icon(CupertinoIcons.xmark),
                                    color: Color(0xFF9A9A9A),
                                  ),
                                ],
                              ),
                            )
                        ],
                      );
                    }),
              );
  }
}
