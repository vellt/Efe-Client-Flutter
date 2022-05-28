import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class CustomBottomSheet extends StatelessWidget {
  const CustomBottomSheet({
    required this.title,
    required this.children,
  });

  final Widget title;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(16.0),
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: Color(0xFFF6F6F6),
        borderRadius: const BorderRadius.all(Radius.circular(16.0)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _dragLine(context),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: [
              Expanded(
                child: Padding(
                  child: title,
                  padding: EdgeInsets.only(
                      top: 15.sp, right: 5.sp, left: 25.sp, bottom: 18.sp),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 10.5.sp, right: 15.sp),
                child: ClipOval(
                  child: Material(
                    color: Colors.transparent, // Button color

                    child: InkWell(
                      splashColor: Colors.grey.shade200, // Splash color
                      hoverColor: Colors.transparent,
                      highlightColor: Colors.grey.shade200,
                      onTap: () {
                        print("added to favorites from heart");
                      },
                      child: SizedBox(
                          width: 56,
                          height: 56,
                          child: Icon(
                            Icons.favorite,
                            size: 26.sp,
                            color: Color(0xFFE8E8E8),
                          )),
                    ),
                  ),
                ),
              ),
            ],
          ),
          Container(
            color: Colors.white,
            child: Column(
              children: children,
            ),
          ),
        ],
      ),
    );
  }

  Widget _dragLine(BuildContext context) {
    final theme = Theme.of(context);
    return Material(
      color: Colors.transparent,
      child: FractionallySizedBox(
        widthFactor: 0.25,
        child: Container(
          margin: const EdgeInsets.symmetric(
            vertical: 12.0,
          ),
          child: InkWell(
            onTap: () {},
            child: Container(
              height: 3.sp,
              decoration: BoxDecoration(
                color: theme.dividerColor,
                borderRadius: const BorderRadius.all(Radius.circular(2.5)),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
