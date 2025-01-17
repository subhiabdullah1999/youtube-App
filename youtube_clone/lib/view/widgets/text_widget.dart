import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class TextWidget extends StatelessWidget {
  final String text;
  final Color color;
  final double fontSize;
  final FontWeight fontWeight;
  final TextAlign textAlign;
  final int maxline;
  final TextDecoration textDecoration;
  TextOverflow overflow;
  TextWidget(
      {Key? key,
      required this.text,
      required this.color,
      required this.fontSize,
      required this.fontWeight,
      required this.textAlign,
      required this.maxline,
      this.overflow = TextOverflow.clip,
      this.textDecoration = TextDecoration.none})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AutoSizeText(
      text,
      style: TextStyle(
        // overflow: overflow,
        decoration: textDecoration,
        color: color,
        fontFamily: 'EuclidCircularARegular',
        fontSize: fontSize,
        fontWeight: fontWeight,
      ),
      textAlign: textAlign,
      maxLines: maxline,
    );
  }
}
