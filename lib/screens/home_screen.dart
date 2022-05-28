import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:uk_vocabulary_builder_flutter/controllers/api_lesson_controller.dart';
import 'package:uk_vocabulary_builder_flutter/controllers/player_controller.dart';
import 'package:uk_vocabulary_builder_flutter/model/audio.dart';
import 'package:uk_vocabulary_builder_flutter/model/book.dart';
import 'package:uk_vocabulary_builder_flutter/utils/constants.dart';
import 'package:uk_vocabulary_builder_flutter/widgets/audio_widget.dart';
import 'package:uk_vocabulary_builder_flutter/widgets/bottom_sheet_list_item.dart';
import 'package:uk_vocabulary_builder_flutter/widgets/custom_bottom_sheet.dart';
import 'package:uk_vocabulary_builder_flutter/widgets/home_appbar_content.dart';
import 'package:uk_vocabulary_builder_flutter/widgets/audio_player.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }
  /*late Book book;
  HomeScreen({required this.book}) {
    apiLessonController.lessonRoute = book.route;
  }

  final ApiLessonController apiLessonController =
      Get.put(ApiLessonController());
  final playerController = Get.put(PlayerController());

  void initData() async {
    await apiLessonController.onInit();
  }

  //betölti a lecke hangjait
  List<Widget> loadAudioContent(BuildContext context) {
    List<Widget> temp = [];
    for (var i = 0; i < apiLessonController.getLesson.audios.length; i++) {
      var audioData = apiLessonController.getLesson.audios[i];
      temp.add(AudioWidget(
          id: i,
          audioData: audioData,
          onPressed: () {
            playerController.play(i, apiLessonController.getLesson.id);
          },
          onLongPressed: () {
            playerController.currentPlayedAudioIndex.value = i;
            _showBottomSheet(context, isHoovered: true);
          },
          isActive: (i ==
                  playerController.currentAtTheMomentPlayedAudioIndex.value) &&
              playerController.isPlaying.value &&
              playerController.currentLessonID ==
                  apiLessonController.getLesson.id,
          isLoading:
              (i == playerController.currentAtTheMomentPlayedAudioIndex.value &&
                      playerController.duration.value == Duration(seconds: 0) &&
                      !playerController.isPlaying.value) &&
                  playerController.currentLessonID ==
                      apiLessonController.getLesson.id,
          isPlaying:
              (i == playerController.currentAtTheMomentPlayedAudioIndex.value &&
                  playerController.isPlaying.value &&
                  playerController.currentLessonID ==
                      apiLessonController.getLesson.id)));
    }
    return temp;
  }

  //betölti a lejátszót
  void _showBottomSheet(BuildContext context, {required bool isHoovered}) {
    playerController.thePlayerIsInPreviewMode.value = isHoovered;
    showModalBottomSheet(
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      context: context,
      builder: (context) {
        return Obx(
          () {
            print("22222222 ${playerController.currentLessonID}");
            print(apiLessonController.getLessonByUniqueIndex(
                    key: playerController.currentLessonID) ==
                null);
            */ /* print(apiLessonController
                .getLessonByUniqueIndex(key: playerController.currentLessonID)
                .audios
                .length);*/ /*
            //[playerController.currentPlayedAudioIndex.value].title)
            return CustomBottomSheet(
              title: Text(
                apiLessonController
                    .getLesson
                    .audios[playerController.currentPlayedAudioIndex.value]
                    .title,
                style: kAudioPlayerTitleTextStyle,
              ),
              children: [
                ((!playerController.thePlayerIsInPreviewMode.value))
                    ? audioPlayer(context,
                        playerController: playerController,
                        lessonID: apiLessonController.getLesson.id)
                    : bottomSheetListItem(context,
                        icon: Icons.play_arrow,
                        title: 'Play this sound', onClick: () {
                        playerController.thePlayerIsInPreviewMode.value = false;
                        playerController.play(
                            playerController.currentPlayedAudioIndex.value,
                            apiLessonController.getLesson.id);
                      }),
              ],
            );
          },
        );
      },
    );
  }

  //----------------------------------------------------------content----------------------

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: apiLessonController.onInit(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            //inicializálás befejeződött
            if (!apiLessonController.isFetchingSuccess) {
              //nem sikerült adatot betölteni
              return Align(
                alignment: Alignment.center,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Internet lost!"),
                    IconButton(
                      onPressed: () =>
                          Get.appUpdate(), //todo ez tuti nem mukodik!!
                      icon: Icon(CupertinoIcons.refresh),
                    )
                  ],
                ),
              );
            } else {
              //sikerült adatot betölteni
              return Scaffold(
                  appBar: AppBar(
                    bottom: PreferredSize(
                      preferredSize: Size.fromHeight(6.h),
                      child: Obx(
                        () {
                          playerController.audioSources = apiLessonController
                              .getAudioSources(); //betöltjök a lejátszóba a hangokat
                          return HomeAppBarContent(
                            currentValue: apiLessonController.getLesson.id,
                            onSubmitted: (text) =>
                                apiLessonController.openLesson(text),
                            backOnPressed: () =>
                                apiLessonController.backLesson(),
                            nextOnPressed: () =>
                                apiLessonController.nextLesson(),
                          );
                        },
                      ),
                    ),
                  ),
                  body: Column(
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
                                      child: Obx(
                                        () => Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              apiLessonController
                                                  .getLesson.title,
                                              style: kHomeTitleTextStyle,
                                            ),
                                            if (apiLessonController
                                                    .getLesson.subtitle !=
                                                null)
                                              Text(
                                                  apiLessonController
                                                      .getLesson.subtitle!,
                                                  style:
                                                      kHomeSubTitleTextStyle),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  Obx(
                                    () => Column(
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.only(bottom: 3.h),
                                          child: (apiLessonController.getLesson
                                                      .audios.length ==
                                                  0)
                                              ? Column(
                                                  children: [
                                                    Align(
                                                      alignment:
                                                          Alignment.center,
                                                      child: Icon(
                                                        CupertinoIcons
                                                            .tray_fill, //CupertinoIcons.speaker_slash,
                                                        size: 30.h,
                                                        color: kMiddleGrayColor,
                                                      ),
                                                    ),
                                                    Text(
                                                      "Empty",
                                                      style:
                                                          kHomeSubTitleTextStyle,
                                                    )
                                                  ],
                                                )
                                              : Align(
                                                  alignment: Alignment.topLeft,
                                                  child: Wrap(
                                                    spacing: 7.w,
                                                    runSpacing: 7.w,
                                                    children: loadAudioContent(
                                                        context), //ide jönnek a konkrét voice widgetek
                                                  ),
                                                ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  floatingActionButton: Obx(
                    () => Container(
                      child: (playerController.isPlaying.value)
                          ? Padding(
                              padding: EdgeInsets.only(right: 10.sp), //15 volt!
                              child: FloatingActionButton(
                                backgroundColor: Color(0xFF707070),
                                onPressed: () => _showBottomSheet(context,
                                    isHoovered: false),
                                child: Stack(
                                  children: [
                                    SpinKitRipple(
                                      color: Color(0xFF636363),
                                      size: 80.sp,
                                    ),
                                    Center(
                                        child: Icon(
                                      CupertinoIcons.waveform_path,
                                      size: 20.sp,
                                      color: Colors.white,
                                    )),
                                  ],
                                ),
                              ),
                            )
                          : Container(),
                    ),
                  ));
            }
          } else {
            return Center(
              child: CircularProgressIndicator(
                color: kMainDarkGrayColor,
              ),
            );
          }
        });
  }*/
}
