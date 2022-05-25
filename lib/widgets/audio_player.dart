import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uk_vocabulary_builder_flutter/controllers/player_controller.dart';
import 'package:sizer/sizer.dart';
import 'package:uk_vocabulary_builder_flutter/utils/duration_extensions.dart';

Widget audioPlayer(
  BuildContext context, {
  required PlayerController playerController,
}) {
  return Column(
    children: [
      Container(
        child: Obx(
          () => Column(
            children: [
              Padding(
                padding: EdgeInsets.only(right: 25.sp, left: 25.sp, top: 12.sp),
                child: Row(
                  children: [
                    Text(
                      playerController.position.value.timeFormat,
                      style: TextStyle(
                        fontSize: 15.sp,
                        color: Color(0xFF818181),
                      ),
                    ),
                    Expanded(
                      child: Slider(
                        activeColor: Color(0xFF636363),
                        inactiveColor: Color(0xFFE8E8E8),
                        value: playerController.position.value.inSeconds
                            .toDouble(),
                        min: 0.0,
                        max: playerController.duration.value.inSeconds
                            .toDouble(),
                        onChanged: (double value) {
                          playerController.setPositionValue = value;
                        },
                      ),
                    ),
                    Text(
                      playerController.duration.value.timeFormat,
                      style: TextStyle(
                        fontSize: 15.sp,
                        color: Color(0xFF818181),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(right: 25.sp, left: 25.sp),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ClipOval(
                      child: Material(
                        color: Colors.transparent, // Button color
                        child: InkWell(
                          // Splash color
                          onTap: () {
                            playerController.back();
                          },
                          child: SizedBox(
                            width: 60.sp,
                            height: 60.sp,
                            child: Icon(
                              Icons.skip_previous,
                              color: Color(0xFF636363),
                              size: 45.sp,
                            ),
                          ),
                        ),
                      ),
                    ),
                    ClipOval(
                      child: Material(
                        color: Colors.transparent, // Button color
                        child: InkWell(
                          // Splash color
                          onTap: () {
                            playerController.resumeOrPause();
                          },
                          child: SizedBox(
                            width: 85.sp,
                            height: 85.sp,
                            child: Icon(
                              (playerController.isPlaying.value)
                                  ? Icons.pause
                                  : Icons.play_arrow,
                              color: Color(0xFF636363),
                              size: 70.sp,
                            ),
                          ),
                        ),
                      ),
                    ),
                    ClipOval(
                      child: Material(
                        color: Colors.transparent, // Button color
                        child: InkWell(
                          // Splash color
                          onTap: () {
                            playerController.next();
                          },
                          child: SizedBox(
                            width: 60.sp,
                            height: 60.sp,
                            child: Icon(
                              Icons.skip_next,
                              color: Color(0xFF636363),
                              size: 45.sp,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: Color(0xFFC8C8C8),
              width: 0.3,
            ),
          ),
        ),
      ),
    ],
  );
}
