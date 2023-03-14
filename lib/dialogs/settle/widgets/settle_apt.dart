import 'package:ax_dapp/service/custom_styles.dart';
import 'package:flutter/material.dart';

class SettleAPT extends StatelessWidget {
  SettleAPT({
    super.key,
    required this.settlementPrice,
    required this.settlementTime,
  });

  final int settlementTime;
  final DateTime settlementDateTime = DateTime.now();
  final double settlementPrice;

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'This APT contract has expired on ${DateTime.fromMicrosecondsSinceEpoch(settlementTime).toLocal()}',
            textAlign: TextAlign.center,
            style: textStyle(
              Colors.white,
              15,
              isBold: false,
              isUline: false,
            ),
          ),
        ],
      ),
    );
  }
}
