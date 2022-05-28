import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

Widget bottomSheetListItem(
  BuildContext context, {
  MainAxisAlignment? mainAxisAlignment,
  IconData? icon,
  required String title,
  required Function() onClick,
}) {
  return Material(
    color: Colors.white,
    child: InkWell(
      onTap: onClick,
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: 10.sp,
          vertical: 18.sp,
        ),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: Color(0xFFC8C8C8),
              width: 0.3,
            ),
          ),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 10.sp,
          ),
          child: Row(
            mainAxisAlignment: mainAxisAlignment ?? MainAxisAlignment.start,
            children: [
              if (icon != null)
                Icon(
                  icon,
                  size: 28.sp,
                  color: Color(0xFF4A4A4A),
                ),
              SizedBox(
                width: 3.w,
              ),
              Text(
                title,
                style: TextStyle(fontSize: 17.sp, color: Color(0xFF4A4A4A)),
              ),
            ],
          ),
        ),
      ),
    ),
  );
}
