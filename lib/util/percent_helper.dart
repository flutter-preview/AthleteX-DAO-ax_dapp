import 'package:flutter/material.dart';

String getPercentageDesc(double percentage) {
  var sign = '';
  if (percentage > 0) {
    sign = '+';
  } else if (percentage < 0) {
    sign = '-';
  }

  return '$sign${percentage.abs().toStringAsFixed(2)}%';
}

Color getPercentageColor(double percentage) {
  return percentage >= 0 ? Colors.green : Colors.red;
}

IconData getPercentStatusIcon(double percentage) {
  return percentage >= 0 ? Icons.trending_up : Icons.trending_down;
}
