import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:minimaxis_app/core/extensions/build_context_utils.dart';
import 'package:minimaxis_app/core/styles/colors.dart';
import 'package:minimaxis_app/core/styles/text_style.dart';

class InputWidget extends StatefulWidget {
  final String title;
  final int maxnumber;
  final TextEditingController controller;
  const InputWidget({super.key, required this.title, required this.controller, required this.maxnumber});

  @override
  State<InputWidget> createState() => _InputWidgetState();
}

class _InputWidgetState extends State<InputWidget> {
  @override
  Widget build(BuildContext context) {
    final styleModifier = context.appTextStyles;
    return Padding(
      padding: const EdgeInsets.all(8.0),
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
                style:
                    GoogleFonts.inter(textStyle: styleModifier.superSmallGray),
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
                color: const Color.fromARGB(255, 31, 4, 4),
                shape: RoundedRectangleBorder(
                  side: const BorderSide(width: 1, color: Color(0xFF8859FE)),
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: TextFormField(
                maxLength: widget.maxnumber,
                controller: widget.controller,
                style: styleModifier.smallWhite,
                decoration: InputDecoration(
                    border: InputBorder.none, fillColor: AppColors.secondary),
              ))
        ],
      ),
    );
  }
}
