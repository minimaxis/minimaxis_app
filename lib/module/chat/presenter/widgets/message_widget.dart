// ignore_for_file: deprecated_member_use

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:minimaxis_app/core/styles/colors.dart';

class MessageWidget extends StatelessWidget {
  final String text;

  const MessageWidget({Key? key, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10.0),
      child: Align(
        alignment: Alignment.topLeft,
        child: Container(
          padding: const EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            color: AppColors.specialColor,
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: TyperAnimatedTextKit(
            text: [text],
            speed: const Duration(milliseconds: 50), // Adjust the speed as needed
            isRepeatingAnimation: false,
            textStyle: const TextStyle(color: Colors.white),
          ),
        ),
      ),
    );
  }
}