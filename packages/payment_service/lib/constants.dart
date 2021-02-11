import 'package:flutter/material.dart';

const kPrimaryColor = Color(0xFFFD5739);
const kBorderColor = Color(0xFFE4E4E4);
const kInputBbColor = Color(0xFFF5F5F5);
const kLabelColor = Color(0xFF24253D);

final otpInputDecoration = InputDecoration(
    contentPadding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 14),
    enabledBorder: outlineInputBorder(),
    focusedBorder: outlineInputBorder(),
    border: outlineInputBorder());

OutlineInputBorder outlineInputBorder() {
  return OutlineInputBorder(
      borderRadius: BorderRadius.circular(15),
      borderSide: BorderSide(color: Colors.grey.shade400));
}
