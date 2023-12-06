import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_webln/flutter_webln.dart';
import 'package:logger/logger.dart';
import 'package:minimaxis_app/module/chat/infra/lightning_network/models/models.dart';

class WebInService extends ChangeNotifier {
  final logger = Logger();

  Future<void> enable() async {
    try {
      await FlutterWebln.enable();
      await Future.delayed(const Duration(seconds: 5));
      Modular.to.navigate("chat");
    } catch (err) {
      logger.e(err);
    }
  }

  Future<void> getInfo() async {
    try {
      await FlutterWebln.getInfo().then(allowInterop((result) {
        var response = weblnDecode(result);
        final info = GetInfo.fromJson(response);
        final node = Node.fromJson(info.node);
        logger.i(node.alias);
      }));
    } catch (err) {
      logger.e(err);
    }
  }

  Future<void> makeInvoice(String? amount) async {
    final invoice = FlutterWebln.requestInvoiceArgs(
        amount: amount, defaultMemo: 'Pay Credits');

    try {
      await FlutterWebln.makeInvoice(requestInvoiceArgs: invoice)
          .then(allowInterop((result) {
        var response = weblnDecode(result);
        var invoice = MakeInvoice.fromJson(response);
        logger.i(invoice);
      }));
    } catch (err) {
      logger.e("[!] Error: $err");
    }
  }
}
