import 'package:flutter/material.dart';

class CustomTextfield extends StatelessWidget {
  final Widget? suffIcon;
  final TextEditingController controller;
  final String? Function(String?)? validator;
  final bool? obsecure;

  const CustomTextfield(
      {super.key,
      this.suffIcon,
      required this.controller,
      this.validator,
      this.obsecure = false});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      validator: validator,
      obscureText: obsecure!,
      decoration: InputDecoration(
          suffixIcon: suffIcon,
          enabled: true,
          focusColor: Color(0xff01AFF0),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide(color: Color(0xff01AFF0)),
          ),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: BorderSide(color: Color(0xff01AFF0))),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: BorderSide(color: Color(0xff01AFF0)))),
    );
  }
}
