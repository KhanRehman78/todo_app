import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  final String? text;
  final double? radius;
  final double? fontsize;
  void Function()? onTap;

   MyButton({super.key, this.text, this.radius, this.fontsize, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 50,
        width: double.infinity,
        decoration: BoxDecoration(
          color: Color(0xff01AFF0),
          borderRadius: BorderRadius.circular(radius!),
        ),
        child: Center(
            child: Text(
          text!,
          style: TextStyle(
              color: Colors.white, fontSize: fontsize, fontWeight: FontWeight.bold),
        )),
      ),
    );
  }
}
