import 'package:exam_dot_mobile/utils/app_colors.dart';
import 'package:flutter/material.dart';

class VText extends StatelessWidget {
  final dynamic title;
  final double fontSize;
  final FontWeight fontWeight;
  final TextOverflow overflow;
  final TextAlign align;
  final bool money;
  final bool number;
  final TextDecoration decoration;
  final int maxLines;
  final Color color;

  VText(this.title,
      {this.fontSize,
      this.fontWeight,
      this.overflow = TextOverflow.ellipsis,
      this.money = false,
      this.number = false,
      this.decoration,
      this.maxLines,
      this.align,
      this.color = AppColors.grey1});

  @override
  Widget build(BuildContext context) {
    return Text(
      title.toString(),
      style: TextStyle(
        fontFamily: "poppinsRegular",
        color: color,
        fontSize: fontSize,
        fontWeight: fontWeight,
        decoration: decoration,
      ),
      overflow: overflow,
      textAlign: align,
      maxLines: maxLines,
    );
  }
}
