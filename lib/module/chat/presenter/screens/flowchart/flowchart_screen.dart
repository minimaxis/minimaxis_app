import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:minimaxis_app/core/extensions/build_context_utils.dart';
import 'package:minimaxis_app/core/styles/colors.dart';
import 'package:minimaxis_app/core/styles/text_style.dart';
import 'package:minimaxis_app/module/chat/presenter/screens/chat/chat_controller.dart';
import 'package:minimaxis_app/module/chat/presenter/widgets/build_appbar.dart';
import 'package:minimaxis_app/module/chat/presenter/widgets/build_drawer.dart';

class FlowchartScreen extends StatefulWidget {
  const FlowchartScreen({Key? key}) : super(key: key);

  @override
  State<FlowchartScreen> createState() => _FlowchartScreenState();
}

class _FlowchartScreenState extends State<FlowchartScreen> {
  @override
  Widget build(BuildContext context) {
    final controller = ChatController();
    final styleModifier = context.appTextStyles;

    return Scaffold(
      backgroundColor: AppColors.onPrimary,
      appBar: buildAppbar(context),
      drawer: buildDrawer(context),
      body: Column(
        children: [
          Container(
              alignment: Alignment.center,
              height: 90,
              width: context.mediaWidth * 1.0,
              decoration: BoxDecoration(
                color: AppColors.secondary,
              ),
              child: LayoutBuilder(builder: ((context, constraints) {
                if (context.mediaWidth > 600) {
                  return Container(
                    alignment: Alignment.center,
                    height: 60,
                    width: context.mediaWidth * 0.9,
                    decoration: BoxDecoration(
                      color: AppColors.specialColor,
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Text(
                      controller.messages[0]['code']!,
                      style: GoogleFonts.inter(
                        textStyle: styleModifier.defaultWhite,
                      ),
                    ),
                  );
                } else {
                  return Container(
                    alignment: Alignment.center,
                    height: 75,
                    width: context.mediaWidth * 0.9,
                    decoration: BoxDecoration(
                      color: AppColors.specialColor,
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Text(
                      controller.messages[0]['code']!,
                      style: GoogleFonts.inter(
                        textStyle: styleModifier.smallWhite,
                      ),
                    ),
                  );
                }
              }))),
          const SizedBox(
            height: 20,
          ),
          Center(child: buildFlowchart()),
        ],
      ),
    );
  }

  Widget buildFlowchart() {
    final controller = ChatController();
    return SizedBox(
        height: context.mediaHeight * 0.6,
        width: context.mediaWidth * 0.8,
        child: Image.asset(controller.messages[0]['flowchart']!));
  }
}
