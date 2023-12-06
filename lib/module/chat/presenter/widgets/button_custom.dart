import 'package:flutter/material.dart';
import 'package:minimaxis_app/core/styles/colors.dart';

class ButtonCustom extends StatelessWidget {
  final String text;
  final VoidCallback callback;
  const ButtonCustom({
    super.key,
    required this.text,
    required this.callback,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: callback,
      child: Container(
        width: 230,
        height: 40,
        decoration: BoxDecoration(
          color: AppColors.specialColor,
          borderRadius: BorderRadius.circular(5)
        ),
      )
    );
  }
}
