import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:uk_vocabulary_builder_flutter/controllers/api_books_controller.dart';
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

class HomeScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _HomeScreenState();
  HomeScreen() {

    print(apiBooksController.selectedBook.id);
    apiLessonController =
        Get.put(ApiLessonController(apiBooksController.selectedBook.route));
  }

  late final ApiLessonController apiLessonController;
  late final PlayerController playerController;
  ApiBooksController apiBooksController = Get.put(ApiBooksController());
  ScrollController controller = new ScrollController();
}

class _HomeScreenState extends State<HomeScreen>
    with AutomaticKeepAliveClientMixin<HomeScreen> {

  //betölti a lecke hangjait
  List<Widget> loadAudioContent(BuildContext context) {
    List<Widget> temp = [];
    List<Audio> audios =
        widget.apiLessonController.getAudioDataOfSelectedLesson();
    for (var i = 0; i < audios.length; i++) {
      var audioData = audios[i];
      temp.add(AudioWidget(
        id: i,
        audioData: audioData,
        onPressed: () {
          widget.playerController
              .play(i, of: widget.apiLessonController.selectedLesson.position);
        },
        onLongPressed: () {
          print("positon ${widget.controller.position.pixels}"); //todo elmenteni a aktuális posito ha valkozik a scroll
          widget.playerController.tempAudioIndex.value = i;
          _showBottomSheet(context, isHoovered: true);
        },
        isActive: (i == widget.playerController.currentAudioIndex.value) &&
            widget.playerController.isPlaying.value &&
            widget.playerController.currentLessonIndex.value ==
                widget.apiLessonController.selectedLessonIndex.value,
        isLoading: false,
        isPlaying: (i == widget.playerController.currentAudioIndex.value &&
            widget.playerController.isPlaying.value &&
            widget.playerController.currentLessonIndex.value ==
                widget.apiLessonController.selectedLessonIndex.value),
      ));
    }
    return temp;
  }

  //betölti a lejátszót
  void _showBottomSheet(BuildContext context, {required bool isHoovered}) {
    widget.playerController.thePlayerIsInPreviewMode.value = isHoovered;
    showModalBottomSheet(
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      context: context,
      builder: (context) {
        return Obx(
          () {
            return CustomBottomSheet(
              title: Text(
                (widget.playerController.thePlayerIsInPreviewMode.value)
                    ? widget
                        .apiLessonController
                        .selectedLesson
                        .audios[widget.playerController.tempAudioIndex.value]
                        .title
                    : widget
                        .apiLessonController
                        .lessons[
                            widget.playerController.currentLessonIndex.value]
                        .audios[widget.playerController.currentAudioIndex.value]
                        .title, //todo: megcsinalni a hang title-t
                style: kAudioPlayerTitleTextStyle,
              ),
              children: [
                ((!widget.playerController.thePlayerIsInPreviewMode.value))
                    ? audioPlayer(context,
                        playerController: widget.playerController,
                        lessonIndex:
                            widget.apiLessonController.selectedLesson.position)
                    : bottomSheetListItem(context,
                        icon: Icons.play_arrow,
                        title: 'Play this sound', onClick: () {
                        widget.playerController.thePlayerIsInPreviewMode.value =
                            false;
                        widget.playerController.play(
                            widget.playerController.tempAudioIndex.value,
                            of: widget
                                .apiLessonController.selectedLesson.position);
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
        future: widget.apiLessonController.onInit(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            //inicializálás befejeződött
            widget.playerController = Get.put(PlayerController(
                currentLessonIndex:
                    widget.apiLessonController.selectedLesson.position));
            print("eddigjo");
            return Scaffold(
              appBar: AppBar(
                bottom: PreferredSize(
                    preferredSize: Size.fromHeight(6.h),
                    child: Obx(
                      () {
                        widget.playerController.audioSources = widget
                            .apiLessonController
                            .getUrlSourceOfAudios(); //betöltjök a lejátszóba a hangokat
                        return HomeAppBarContent(
                          currentValue:
                              widget.apiLessonController.selectedLesson.id,
                          onSubmitted: (text) {
                            widget.apiLessonController.openLesson(text);
                          },
                          backOnPressed: () {
                            widget.apiLessonController.backLesson();
                          },
                          nextOnPressed: () =>
                              widget.apiLessonController.nextLesson(),
                        );
                      },
                    )),
              ),
              body: Column(
                children: [
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 8.w),
                      child: SingleChildScrollView(
                        controller: widget.controller,
                        child: Padding(
                          padding: EdgeInsets.symmetric(vertical: 5.h),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                          widget.apiLessonController
                                              .selectedLesson.title,
                                          style: kHomeTitleTextStyle,
                                        ),
                                        if (widget.apiLessonController
                                                .selectedLesson.subtitle !=
                                            null)
                                          Text(
                                              widget.apiLessonController
                                                  .selectedLesson.subtitle!,
                                              style: kHomeSubTitleTextStyle),
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
                                      child: (widget
                                                  .apiLessonController
                                                  .selectedLesson
                                                  .audios
                                                  .length ==
                                              0)
                                          ? Column(
                                              children: [
                                                Align(
                                                  alignment: Alignment.center,
                                                  child: Icon(
                                                    CupertinoIcons
                                                        .tray_fill, //CupertinoIcons.speaker_slash,
                                                    size: 30.h,
                                                    color: kMiddleGrayColor,
                                                  ),
                                                ),
                                                Text(
                                                  "Empty",
                                                  style: kHomeSubTitleTextStyle,
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
                  child: (widget.playerController.isPlaying.value)
                      ? Padding(
                          padding: EdgeInsets.only(right: 10.sp), //15 volt!
                          child: FloatingActionButton(
                            backgroundColor: Color(0xFF707070),
                            onPressed: () =>
                                _showBottomSheet(context, isHoovered: false),
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
              ),
            );
          } else {
            return Center(
              child: CircularProgressIndicator(
                color: kMainDarkGrayColor,
              ),
            );
          }
        });
  }

  @override
  bool get wantKeepAlive => true;
}
