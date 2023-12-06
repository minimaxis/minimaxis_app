import 'dart:async';

import 'package:flutter/material.dart';

class CreditController {
  final TextEditingController satsController = TextEditingController();
  final TextEditingController creditsController = TextEditingController();
  double credits = 0.0;
  late StreamController<double> creditsStreamController;

  CreditController() {
    creditsStreamController = StreamController<double>();
    _initCreditUpdate();
  }

  void _initCreditUpdate() {
    satsController.addListener(() {
      double sats = double.tryParse(satsController.text) ?? 0.0;
      double updatedCredits = sats * 0.1;

      credits = updatedCredits;
      creditsController.text = updatedCredits.toString();

      creditsStreamController.add(updatedCredits);
    });
  }

  void dispose() {
    satsController.dispose();
    creditsController.dispose();
    creditsStreamController.close();
  }
}
