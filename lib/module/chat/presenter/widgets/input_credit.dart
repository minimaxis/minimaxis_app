import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:minimaxis_app/core/extensions/build_context_utils.dart';
import 'package:minimaxis_app/core/styles/colors.dart';
import 'package:minimaxis_app/core/styles/text_style.dart';

class InputCredit extends StatefulWidget {
  final String title;
  final TextEditingController controller;
  const InputCredit({super.key, required this.title, required this.controller});

  @override
  State<InputCredit> createState() => _InputCreditState();
}

class _InputCreditState extends State<InputCredit> {
  @override
  Widget build(BuildContext context) {
    final styleModifier = context.appTextStyles;
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        children: [
          LayoutBuilder(builder: (context, contraints) {
            if (context.mediaWidth < 600) {
              return Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    widget.title,
                    style: GoogleFonts.inter(
                        textStyle: styleModifier.superSmallGray),
                  ));
            } else {
              return Text(
                widget.title,
                style: GoogleFonts.inter(
                    textStyle: styleModifier.superSmallGray),
              );
            }
          }),
          const SizedBox(
            height: 5,
          ),
          Container(
              width: 351,
              height: 49,
              decoration: ShapeDecoration(
                color: const Color(0xFF333333),
                shape: RoundedRectangleBorder(
                  side: const BorderSide(width: 1, color: Color(0xFF8859FE)),
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: TextFormField(
                maxLength: 6,
                controller: widget.controller,
                style: styleModifier.smallWhite,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  fillColor: AppColors.secondary
                ),
              ))
        ],
      ),
    );
  }
}
