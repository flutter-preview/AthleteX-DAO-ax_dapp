import 'package:ax_dapp/service/custom_styles.dart';
import 'package:flutter/material.dart';

class SettleAPT extends StatelessWidget {
  const SettleAPT({
    super.key,
    required this.tokenAddress,
  });

  final String tokenAddress;

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'This will be used later',
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
