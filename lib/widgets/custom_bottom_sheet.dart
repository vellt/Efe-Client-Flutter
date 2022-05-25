import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class CustomBottomSheet extends StatefulWidget {
  const CustomBottomSheet({
    required this.title,
    required this.child,
    required this.children,
  });

  final Widget title;
  final Widget child;
  final List<Widget> children;

  @override
  _CustomBottomSheetState createState() => _CustomBottomSheetState();
}

class _CustomBottomSheetState extends State<CustomBottomSheet> {
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
          Align(
            alignment: Alignment.bottomLeft,
            child: Padding(
              child: widget.title,
              padding: EdgeInsets.only(
                  top: 15.sp, right: 25.sp, left: 25.sp, bottom: 18.sp),
            ),
          ),
          Container(
            color: Colors.white,
            child: Column(
              children: widget.children,
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
