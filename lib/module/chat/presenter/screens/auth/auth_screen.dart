// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:minimaxis_app/core/extensions/build_context_utils.dart';
import 'package:minimaxis_app/core/styles/colors.dart';
import 'package:minimaxis_app/core/styles/text_style.dart';
// import 'package:minimaxis_app/main.dart';
import 'package:minimaxis_app/module/chat/infra/lightning_network/service/webln_service.dart';
import 'package:minimaxis_app/module/chat/presenter/widgets/button_custom.dart';
import 'package:minimaxis_app/module/chat/presenter/widgets/input_credit.dart';
import 'package:provider/provider.dart';
import 'package:qr_flutter/qr_flutter.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({Key? key}) : super(key: key);

  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    final weblnService = Provider.of<WebInService>(context, listen: false);
    return Scaffold(
      backgroundColor: AppColors.onPrimary,
      appBar: AppBar(
        backgroundColor: AppColors.onPrimary,
        leading: Center(
          child: SizedBox(
            width: 149,
            height: 101.59,
            child: Image.asset('assets/logo-2.png'),
          ),
        ),
        leadingWidth: context.mediaWidth * 1.0,
        toolbarHeight: 200,
        elevation: 0,
      ),
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              buildCustomButton(0, 'Guest'),
              buildCustomButton(1, 'E-mail'),
              buildCustomButton(2, 'L. Network'),
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          IndexedStack(
            index: selectedIndex,
            children: [
              const Center(child: GuestComponent()),
              const Center(child: EmailComponent()),
              Center(
                child: LightningNetworkComponent(
                  callback: () => weblnService.enable(),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget buildCustomButton(int index, String text) {
    return InkWell(
      onTap: () {
        setState(() {
          selectedIndex = index;
        });
      },
      child: Column(
        children: [
          Text(
            text,
            style: TextStyle(
              color: index == selectedIndex ? Colors.blue : Colors.grey,
              decoration: TextDecoration.none,
            ),
          ),
          Container(
            height: 1.5,
            width: 100,
            color: index == selectedIndex ? Colors.blue : Colors.transparent,
          ),
        ],
      ),
    );
  }
}

class GuestComponent extends StatelessWidget {
  const GuestComponent({super.key});

  @override
  Widget build(BuildContext context) {
    final styleModifier = context.appTextStyles;
    return Column(
      children: [
        const SizedBox(
          height: 10,
        ),
        Text(
          "Click on QRCODE to log in.",
          style: styleModifier.defaultWhite,
        ),
        const SizedBox(
          height: 20,
        ),
        InkWell(
          onTap: () {
            // id = "Guest";
            Modular.to.navigate("chat");
          },
          child: QrImageView(
            data: "NotData",
            version: QrVersions.auto,
            size: 180,
            backgroundColor: AppColors.secondary,
          ),
        ),
      ],
    );
  }
}

class LightningNetworkComponent extends StatelessWidget {
  final VoidCallback callback;
  const LightningNetworkComponent({super.key, required this.callback});

  @override
  Widget build(BuildContext context) {
    final styleModifier = context.appTextStyles;
    return Column(
      children: [
        const SizedBox(
          height: 10,
        ),
        Text(
          "Click on QRCODE to log in.",
          style: styleModifier.defaultWhite,
        ),
        const SizedBox(
          height: 20,
        ),
        InkWell(
          onTap: callback,
          child: QrImageView(
            data: "NotData",
            version: QrVersions.auto,
            size: 180,
            backgroundColor: AppColors.secondary,
          ),
        ),
      ],
    );
  }
}

class EmailComponent extends StatelessWidget {
  const EmailComponent({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = TextEditingController();
    return Column(
      children: [
        InputWidget(
          title: "E-mail",
          controller: controller,
          maxnumber: 99,
        ),
        const SizedBox(
          height: 10,
        ),
        ButtonCustom(
          text: "Login",
          callback: () {
            Modular.to.navigate("chat");
          },
        )
      ],
    );
  }
}

