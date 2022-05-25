import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:uk_vocabulary_builder_flutter/model/audio.dart';
import 'package:uk_vocabulary_builder_flutter/utils/constants.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class AudioWidget extends StatelessWidget {
  late int id;
  late Audio audioData;
  late void Function() onPressed;
  late void Function() onLongPressed;
  late bool isActive;
  late bool isLoading;
  late bool isPlaying;
  AudioWidget({
    Key? key,
    required this.id,
    required this.audioData,
    required this.onPressed,
    required this.onLongPressed,
    required this.isActive,
    required this.isLoading,
    required this.isPlaying,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onLongPress: () => onLongPressed(),
      onTap: () => onPressed(),
      child: Container(
        width: 38.w,
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                color: kLightGrayColor,
                borderRadius: BorderRadius.circular(25.sp),
              ),
              width: 38.w,
              height: 38.w,
              child: Stack(
                children: [
                  if (isPlaying)
                    SpinKitRipple(
                      color: Color(0xFFD6D6D6),
                      size: 30.w,
                    ),
                  if (isLoading)
                    SpinKitDualRing(
                      color: Color(0xFFD6D6D6),
                      size: 20.w,
                    ),
                  Center(
                    child: Stack(
                      children: [
                        Center(
                          child: CircleAvatar(
                            radius: 15.sp,
                            backgroundColor: Colors.white,
                          ),
                        ),
                        Center(
                          child: Icon(
                            CupertinoIcons.play_circle_fill,
                            size: 40.sp,
                            color:
                                (isActive) ? kNightGrayColor : kDarkGrayColor,
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 1.5.h),
              child: Text.rich(
                TextSpan(
                  children: [
                    if (audioData.isFavorite)
                      WidgetSpan(
                        alignment: PlaceholderAlignment.middle,
                        child: Icon(
                          Icons.favorite,
                          size: 14.sp,
                          color: Color(0xFFFF7777),
                        ),
                      ),
                    if (audioData.isFavorite)
                      WidgetSpan(
                        child: SizedBox(
                          width: 2.w,
                        ),
                      ),
                    TextSpan(
                      text: audioData.title,
                      style: (isActive)
                          ? kVoiceElementNightTextStyle
                          : kVoiceElementDarkTextStyle,
                    ),
                  ],
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
