import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:minimaxis_app/core/extensions/build_context_utils.dart';
import 'package:minimaxis_app/core/styles/colors.dart';
import 'package:minimaxis_app/core/styles/text_style.dart';

AppBar buildAppbar(BuildContext context) {
  final styleModifier = context.appTextStyles;
  return AppBar(
    backgroundColor: AppColors.onPrimary,
    leadingWidth: context.mediaWidth * 1.0,
    toolbarHeight: 60,
    leading: Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Builder(
          builder: (BuildContext context) {
            return IconButton(
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
              icon: Icon(
                Icons.menu,
                color: AppColors.onSecondary,
                size: 26,
              ),
            );
          },
        ),
        InkWell(
          onTap: () {
            Modular.to.navigate("chat");
          },
          child: Container(
            height: 35,
            width: 140,
            decoration: BoxDecoration(
                color: AppColors.secondary,
                borderRadius: BorderRadius.circular(5.0)),
            alignment: Alignment.center,
            child: Text(
              "Clear",
              style: GoogleFonts.inter(textStyle: styleModifier.smallWhite),
            ),
          ),
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 20.27,
              width: 30.4,
              child: Image.asset('assets/text-img.png'),
            ),
            const SizedBox(
              width: 5,
            ),
            Text(
              "100%",
              style: GoogleFonts.inter(textStyle: styleModifier.smallWhite),
            )
          ],
        )
      ],
    ),
    elevation: 0,
  );
}
