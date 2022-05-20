import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:uk_vocabulary_builder_flutter/utils/constants.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class VoiceElement extends StatelessWidget {
  late String title;
  late String voiceUrl;
  late void Function(String voice) onPressed;
  late bool isActive;
  late bool isLoading;
  late bool isPlaying;
  VoiceElement({
    Key? key,
    required this.title,
    required this.voiceUrl,
    required this.onPressed,
    required this.isActive,
    required this.isLoading,
    required this.isPlaying,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onPressed(this.voiceUrl);
      },
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
              child: Text(
                title,
                textAlign: TextAlign.center,
                style: (isActive)
                    ? kVoiceElementNightTextStyle
                    : kVoiceElementDarkTextStyle,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
