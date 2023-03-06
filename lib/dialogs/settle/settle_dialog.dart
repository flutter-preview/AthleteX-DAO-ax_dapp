import 'package:ax_dapp/dialogs/settle/bloc/settle_dialog_bloc.dart';
import 'package:ax_dapp/dialogs/settle/widgets/settle_approve_button.dart';
import 'package:ax_dapp/dialogs/settle/widgets/settle_apt.dart';
import 'package:ax_dapp/scout/models/athlete_scout_model.dart';

import 'package:ax_dapp/service/custom_styles.dart';
import 'package:flutter/foundation.dart';
import 'package:ax_dapp/service/controller/scout/long_short_pair_repository.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tokens_repository/tokens_repository.dart';

class SettleDialog extends StatefulWidget {
  const SettleDialog({
    required this.athlete,
    super.key,
  });

  final AthleteScoutModel athlete;

  @override
  State<StatefulWidget> createState() => _SettleDialogState();
}

class _SettleDialogState extends State<SettleDialog> {
  double paddingHorizontal = 20;
  double hgt = 500;

  @override
  Widget build(BuildContext context) {
    final isWeb =
        kIsWeb && (MediaQuery.of(context).orientation == Orientation.landscape);
    final _height = MediaQuery.of(context).size.height;
    final wid = isWeb ? 400.0 : 355.0;

    return BlocConsumer<SettleDialogBloc, SettleDialogState>(
      listener: (context, state) {},
      builder: (context, state) {
        final bloc = context.read<SettleDialogBloc>();
        final settlementPrice = state.settlementPrice;
        final longRedeem = state.longAPTAmount;
        final shortRedeem = state.shortAPTAmount;

        return Dialog(
          insetPadding: EdgeInsets.zero,
          backgroundColor: Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: paddingHorizontal),
            height: hgt,
            width: wid,
            decoration: boxDecoration(Colors.grey[900]!, 30, 0, Colors.black),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SizedBox(
                  width: wid,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Settle your ${widget.athlete.name} APT',
                        style: textStyle(
                          Colors.white,
                          20,
                          isBold: false,
                          isUline: false,
                        ),
                      ),
                      IconButton(
                        icon: const Icon(
                          Icons.close,
                          color: Colors.white,
                          size: 30,
                        ),
                        onPressed: () => Navigator.pop(context),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  width: wid,
                  child: RichText(
                    text: TextSpan(
                      children: <TextSpan>[
                        TextSpan(
                          text:
                              'Your ${widget.athlete.name} has settled!  You can now redeem it for its book price of ${widget.athlete.longTokenBookPrice} AX',
                          style: textStyle(
                            Colors.grey[600]!,
                            isWeb ? 14 : 12,
                            isBold: false,
                            isUline: false,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Divider(
                  thickness: 0.35,
                  color: Colors.grey[400],
                ),
                SettleAPT(settlementPrice: settlementPrice),
                SettleApproveButton(
                  width: 175,
                  height: 40,
                  text: 'Approve',
                  athlete: widget.athlete,
                  approveCallback: () {
                    final currentAxt =
                        context.read<TokensRepository>().currentAxt;
                    return bloc.longShortPairRepository
                        .approve(currentAxt.address);
                  },
                  confirmCallback: bloc.longShortPairRepository.settle,
                )
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
