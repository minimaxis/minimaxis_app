import 'package:flutter/material.dart';

extension BuildContextUtils on BuildContext {
  double get mediaHeight => MediaQuery.of(this).size.height;
  double get mediaWidth => MediaQuery.of(this).size.width;
}