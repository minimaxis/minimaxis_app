import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:minimaxis_app/core/styles/colors.dart';
import 'package:minimaxis_app/core/styles/text_style.dart';

class ButtonCustom extends StatelessWidget {
  final String text;
  final VoidCallback callback;
  const ButtonCustom({
    super.key,
    required this.text,
    required this.callback,
  });

  @override
  Widget build(BuildContext context) {
    final styleModifier = context.appTextStyles;
    return InkWell(
      onTap: callback,
      child: Container(
        alignment: Alignment.center,
        width: 230,
        height: 40,
        decoration: BoxDecoration(
          color: AppColors.specialColor,
          borderRadius: BorderRadius.circular(5)
        ),
        child: Text(text, style: GoogleFonts.inter(
          textStyle: styleModifier.defaultWhite
        ),),
      )
    );
  }
}
