import 'package:ax_dapp/service/custom_styles.dart';
import 'package:flutter/material.dart';

class SettleAPT extends StatelessWidget {
  const SettleAPT({
    super.key,
    required this.settlementPrice,
  });

  final double settlementPrice;

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'You recieve: $settlementPrice AX ',
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
