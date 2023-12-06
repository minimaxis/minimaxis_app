import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:minimaxis_app/core/styles/colors.dart';
import 'package:minimaxis_app/core/styles/text_style.dart';

class TextInputWidget extends StatelessWidget {
  final TextEditingController textController;
  final void Function() onSendPressed;

  const TextInputWidget({
    required this.textController,
    required this.onSendPressed,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final styleModifier = context.appTextStyles;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Flexible(
          child: Container(
            padding: const EdgeInsets.all(4),
            margin: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.10000000149011612),
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(12),
                bottom: Radius.circular(12),
              ),
            ),
            child: TextFormField(
              cursorColor: AppColors.primary,
              controller: textController,
              minLines: 1,
              maxLines: 6,
              keyboardType: TextInputType.multiline,
              style: GoogleFonts.inter(
                textStyle: styleModifier.defaultWhite,
              ),
              onEditingComplete: () {
                onSendPressed();
                textController.clear(); 
              },
              decoration: InputDecoration(
                disabledBorder: InputBorder.none,
                suffixIconColor: AppColors.primary,
                filled: false,
                border: InputBorder.none,
                suffixIcon: IconButton(
                  icon: const Icon(Icons.send),
                  onPressed: onSendPressed,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
