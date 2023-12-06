import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:minimaxis_app/core/extensions/build_context_utils.dart';
import 'package:minimaxis_app/core/styles/colors.dart';
import 'package:minimaxis_app/core/styles/text_style.dart';

class BoxText extends StatelessWidget {
  final String title;
  const BoxText({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    final styleModifier = context.appTextStyles;
    return Container(
      alignment: Alignment.center,
      height: 32,
      width: context.mediaWidth * 0.8,
      decoration: BoxDecoration(
          color: AppColors.secondary, borderRadius: BorderRadius.circular(5)),
      child: Text(
        title,
        style: GoogleFonts.inter(textStyle: styleModifier.smallWhite),
      ),
    );
  }
}
