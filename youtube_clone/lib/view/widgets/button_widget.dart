import 'package:flutter/material.dart';
import 'package:youtube_clone/utils/variables_and_func.dart';

class ButtonWidget extends StatelessWidget {
  // ignore: prefer_typing_uninitialized_variables
  final onTap;
  final Widget text;
  final Color color;
  final double radius;
  final double width;
  final double height;
  final Widget icon;

  const ButtonWidget(
      {Key? key,
      required this.onTap,
      required this.text,
      required this.color,
      required this.radius,
      required this.width,
      required this.height,
      required this.icon})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: ElevatedButton(
        onPressed: onTap,
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(radius),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            text,
            SizedBox(
              width: getWidthInPercent(context, 3),
            ),
            icon
          ],
        ),
      ),
    );
  }
}
