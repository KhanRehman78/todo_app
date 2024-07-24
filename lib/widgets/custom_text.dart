import 'package:flutter/material.dart';

class MyText extends StatelessWidget {
  final String? text;
  final Color? textColor;
  final FontWeight? fontWeight;
  final double? fontsize;

  const MyText(
      {super.key, this.text, this.textColor, this.fontWeight, this.fontsize});

  @override
  Widget build(BuildContext context) {
    return Text(
      text!,
      style: TextStyle(
          color: textColor, fontWeight: fontWeight, fontSize: fontsize),
    );
  }
}
