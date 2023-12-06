import 'package:flutter/material.dart';
import 'package:minimaxis_app/core/styles/colors.dart';
import 'package:qr_flutter/qr_flutter.dart';

class CustomQRCode extends StatelessWidget {
  const CustomQRCode({Key? key, required this.qrData}) : super(key: key);
  final String qrData;

  @override
  Widget build(BuildContext context) {
    return Card(
        color: AppColors.secondary,
        child: QrImageView(
          data: qrData,
          version: QrVersions.auto,
          size: 180,
          backgroundColor: AppColors.secondary,
          errorCorrectionLevel: QrErrorCorrectLevel.M,
          errorStateBuilder: ((context, error) {
            return const Icon(Icons.error_outline);
          }),
        ));
  }
}
