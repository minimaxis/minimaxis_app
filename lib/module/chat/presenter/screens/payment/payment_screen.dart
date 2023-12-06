import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:minimaxis_app/core/extensions/build_context_utils.dart';
import 'package:minimaxis_app/core/styles/colors.dart';
import 'package:minimaxis_app/core/styles/text_style.dart';

class PaymentScreen extends StatelessWidget {
  const PaymentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final styleModifier = context.appTextStyles;
    return Scaffold(
      backgroundColor: AppColors.onPrimary,
      appBar: AppBar(
        backgroundColor: AppColors.onPrimary,
        leading: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            InkWell(
              onTap: () {
                Modular.to.navigate('credit');
              },
              child: Text(
                "Cancel",
                style:
                    GoogleFonts.inter(textStyle: styleModifier.mediumSpecial),
              ),
            ),
            const SizedBox(
              width: 20,
            ),
            SizedBox(
              width: 80.87,
              height: 55,
              child: Image.asset('assets/logo-2.png'),
            )
          ],
        ),
        leadingWidth: context.mediaWidth * 1.0,
        toolbarHeight: 100,
        elevation: 0,
      ),
    );
  }
}
