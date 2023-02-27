import 'package:ax_dapp/service/custom_styles.dart';
import 'package:flutter/material.dart';

class YouRecieve extends StatelessWidget {
  const YouRecieve({
    super.key,
    required this.settledAmount,
  });

  final double settledAmount;

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Text(
                'You Receive: ',
                style: textStyle(
                  Colors.white,
                  15,
                  isBold: true,
                  isUline: true,
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                children: [
                  SizedBox(
                    width: 315,
                    child: FittedBox(
                      fit: BoxFit.fitWidth,
                      child: Text(
                        '${settledAmount.toStringAsExponential(6)} redeemed AX',
                        style: textStyle(
                          Colors.white,
                          15,
                          isBold: false,
                          isUline: false,
                        ),
                      ),
                    ),
                  )
                ],
              )
            ],
          )
        ],
      ),
    );
  }
}
