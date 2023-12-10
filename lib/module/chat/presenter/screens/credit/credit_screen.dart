import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:minimaxis_app/core/extensions/build_context_utils.dart';
import 'package:minimaxis_app/core/styles/colors.dart';
import 'package:minimaxis_app/core/styles/text_style.dart';
import 'package:minimaxis_app/module/chat/infra/lightning_network/service/webln_service.dart';
import 'package:minimaxis_app/module/chat/presenter/screens/credit/credit_controller.dart';
import 'package:minimaxis_app/module/chat/presenter/widgets/custom_qrcode.dart';
import 'package:minimaxis_app/module/chat/presenter/widgets/input_credit.dart';
import 'package:provider/provider.dart';

class CreditScreen extends StatefulWidget {
  const CreditScreen({Key? key}) : super(key: key);

  @override
  State<CreditScreen> createState() => _CreditScreenState();
}

class _CreditScreenState extends State<CreditScreen> {
  late CreditController _creditController;

  @override
  void initState() {
    super.initState();
    _creditController = CreditController();
  }

  @override
  void dispose() {
    _creditController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final weblnService = Provider.of<WebInService>(context, listen: false);
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
                Modular.to.navigate('chat');
              },
              child: Text(
                "Return",
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
      body: Center(
        child: Column(
          children: [
            StreamBuilder<double>(
              stream: _creditController.creditsStreamController.stream,
              initialData: _creditController.credits,
              builder: (context, snapshot) {
                String formattedAmount = snapshot.data!.toStringAsFixed(2);
                return BalanceCredit(amount: formattedAmount);
              },
            ),
            InputWidget(
              title: "Satoshi",
              maxnumber: 6,
              controller: _creditController.satsController,
            ),
            const SizedBox(
              height: 20,
            ),
            InkWell(
              onTap: () => weblnService
                  .makeInvoice(_creditController.satsController.text),
              child: const CustomQRCode(
                qrData: "",
              ),
            ),
            const SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }
}

class BalanceCredit extends StatelessWidget {
  final String amount;
  const BalanceCredit({Key? key, required this.amount}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final styleModifier = context.appTextStyles;

    return Container(
      width: 249,
      height: 92,
      decoration: BoxDecoration(
        color: AppColors.secondary,
        borderRadius: BorderRadius.circular(6),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Text(
            "CREDIT",
            style:
                GoogleFonts.inter(textStyle: styleModifier.superSmallSpecial),
          ),
          Text(
            amount,
            style: GoogleFonts.inter(textStyle: styleModifier.bigYellow),
          ),
        ],
      ),
    );
  }
}
