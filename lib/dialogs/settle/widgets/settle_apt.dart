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
            'The settlement price for the APT is: α$settlementPrice',
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
