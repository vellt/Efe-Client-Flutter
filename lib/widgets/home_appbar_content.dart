import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:sizer/sizer.dart';
import 'package:uk_vocabulary_builder_flutter/utils/constants.dart';

class HomeAppBarContent extends StatelessWidget {
  final String currentValue;
  final void Function(String text) onSubmitted;
  final void Function() backOnPressed;
  final void Function() nextOnPressed;

  HomeAppBarContent({
    Key? key,
    required this.currentValue,
    required this.onSubmitted,
    required this.backOnPressed,
    required this.nextOnPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController _controller = TextEditingController();
    _controller.text = currentValue;
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: IconButton(
                icon: Icon(Ionicons.chevron_back_outline),
                color: kDarkGrayColor,
                iconSize: 4.5.h,
                onPressed: () {
                  backOnPressed();
                },
              ),
            ),
            Container(
                width: 50.w,
                decoration: BoxDecoration(
                    border: Border.all(color: kLightGrayColor, width: 0.4.h),
                    borderRadius: BorderRadius.all(Radius.circular(1.5.h))),
                child: Row(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 2.w),
                        child: TextField(
                          controller: _controller,
                          onSubmitted: (_) => onSubmitted(_controller.text),
                          keyboardType: TextInputType.number,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 18.sp,
                            color: kMiddleGrayColor,
                          ),
                          decoration: InputDecoration(
                              hintText: kHomeSearchInputHintText,
                              hintStyle: TextStyle(color: kMiddleGrayColor),
                              border: InputBorder.none),
                        ),
                      ),
                    ),
                    Container(
                      height: 33.sp,
                      width: 67.sp,
                      child: TextButton(
                        onPressed: () => onSubmitted(_controller.text),
                        child:
                            Text(kHomeSearchText, style: kHomeSearchTextStyle),
                        style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all(kMainDarkGrayColor)),
                      ),
                    ),
                    SizedBox(
                      width: 1.1.w,
                    )
                  ],
                )),
            Expanded(
              child: IconButton(
                  icon: Icon(Ionicons.chevron_forward_outline),
                  color: kDarkGrayColor,
                  iconSize: 4.5.h,
                  onPressed: () {
                    nextOnPressed();
                  }),
            ),
          ],
        ),
        SizedBox(
          height: 3.h,
        ),
      ],
    );
  }
}
