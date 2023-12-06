import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:minimaxis_app/core/extensions/build_context_utils.dart';
import 'package:minimaxis_app/core/styles/colors.dart';
import 'package:minimaxis_app/core/styles/text_style.dart';
import 'package:minimaxis_app/main.dart';
import 'package:minimaxis_app/module/chat/presenter/widgets/box_text.dart';

Drawer buildDrawer(BuildContext context) {
  final styleModifier = context.appTextStyles;
  final currentPage = Modular.to.path;

  Widget buildMenuItem(String title, String route) {
    bool isSelected = currentPage == route;

    return InkWell(
      onTap: () {
        if (!isSelected) {
          Modular.to.navigate(route);
        }
      },
      child: Row(
        children: [
          SizedBox(
            height: 18,
            width: 18,
            child: Image.asset(
              isSelected ? 'assets/check.png' : 'assets/empty_check.png',
            ),
          ),
          const SizedBox(
            width: 5,
          ),
          Text(
            title,
            style: GoogleFonts.inter(
              textStyle: isSelected
                  ? styleModifier.smallWhite
                  : styleModifier.smallGray,
            ),
          ),
        ],
      ),
    );
  }

  return Drawer(
    backgroundColor: AppColors.onPrimary,
    child: ListView(
      padding: EdgeInsets.zero,
      children: [
        DrawerHeader(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  SizedBox(
                    height: 48,
                    width: 52.80,
                    child: Image.asset('assets/logo.png'),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Container(
                    alignment: Alignment.center,
                    height: 40,
                    width: 100,
                    decoration: BoxDecoration(
                      color: AppColors.secondary,
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Text(
                      id,
                      style: GoogleFonts.inter(
                        textStyle: styleModifier.smallWhite,
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  IconButton(
                    onPressed: () => Modular.to.navigate("/"),
                    icon: Icon(
                      Icons.logout,
                      size: 24,
                      color: AppColors.redColor,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                "View",
                style: GoogleFonts.inter(
                  textStyle: styleModifier.smallWhite,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Column(
                children: [
                  buildMenuItem("Message", "/chat"),
                  const SizedBox(
                    height: 10,
                  ),
                  buildMenuItem("Flowchart", "/flowchart"),
                ],
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Credit",
                style: GoogleFonts.inter(
                  textStyle: styleModifier.smallSuperWhite,
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              Container(
                alignment: Alignment.center,
                height: 32,
                width: context.mediaWidth * 0.8,
                decoration: BoxDecoration(
                  color: AppColors.secondary,
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.credit_card,
                            color: AppColors.onSecondary,
                            size: 12,
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Text(
                            "2.000",
                            style: GoogleFonts.inter(
                              textStyle: styleModifier.smallYellow,
                            ),
                          ),
                        ],
                      ),
                      InkWell(
                        onTap: () {
                          Modular.to.navigate("credit");
                        },
                        child: Text(
                          "Buy Credit",
                          style: GoogleFonts.inter(
                            textStyle: styleModifier.smallSpecial,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                "Current Category",
                style: GoogleFonts.inter(
                  textStyle: styleModifier.smallSuperWhite,
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              BoxText(
                title: currentConversation,
              ),
              // const SizedBox(
              //   height: 10,
              // ),
              // Text(
              //   "Past Conversation",
              //   style: GoogleFonts.inter(
              //     textStyle: styleModifier.smallSuperWhite,
              //   ),
              // ),
              // const SizedBox(
              //   height: 5,
              // ),
              // const BoxText(
              //   title: "In development",
              // ),
            ],
          ),
        ),
      ],
    ),
  );
}
