import 'package:ax_dapp/farm/dialogs/unstake/bloc/unstake_bloc.dart';
import 'package:ax_dapp/farm/widgets/widgets.dart';
import 'package:ax_dapp/service/controller/farms/farm_controller.dart';
import 'package:ax_dapp/service/custom_styles.dart';
import 'package:ax_dapp/util/bloc_status.dart';
import 'package:ax_dapp/util/warning_text_button.dart';
import 'package:ax_dapp/wallet/bloc/wallet_bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wallet_repository/wallet_repository.dart';

class UnStakeDialog extends StatefulWidget {
  const UnStakeDialog({
    required this.farm,
    required this.layoutWdt,
    super.key,
  });

  final FarmController farm;
  final double layoutWdt;

  @override
  State<StatefulWidget> createState() => _UnStakeDialogState();
}

class _UnStakeDialogState extends State<UnStakeDialog> {
  final unStakeAxInputController = TextEditingController();
  @override
  void dispose() {
    unStakeAxInputController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isWeb =
        kIsWeb && (MediaQuery.of(context).orientation == Orientation.landscape);
    final _height = MediaQuery.of(context).size.height;
    final wid = isWeb ? 390.0 : widget.layoutWdt;
    final hgt = _height < 455.0 ? _height : 450.0;
    const dialogHorPadding = 30.0;
    final selectedFarm = FarmController.fromFarm(
      farm: widget.farm,
      walletRepository: context.read<WalletRepository>(),
    );
    return BlocBuilder<UnStakeBloc, UnStakeState>(
      builder: (context, state) {
        final bloc = context.read<UnStakeBloc>();
        final fundsRemoved = state.fundsRemoved;
        final newBalance = state.newBalance;
        final currentStaked = state.currentStaked;
        final stakedSymbol = state.stakedSymbol;
        final stakedAlias = state.stakedAlias;
        final status = state.status;
        return Dialog(
          insetPadding: EdgeInsets.zero,
          backgroundColor: Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: Container(
            height: hgt,
            width: wid,
            padding: const EdgeInsets.symmetric(
              vertical: 22,
              horizontal: dialogHorPadding,
            ),
            decoration: boxDecoration(Colors.grey[900]!, 30, 0, Colors.black),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Unstake Liquidity',
                      style: textStyle(
                        Colors.white,
                        20,
                        isBold: false,
                        isUline: false,
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Icon(
                        Icons.close,
                        size: 30,
                        color: Colors.white,
                      ),
                    )
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    //Amount Box
                    Container(
                      margin: const EdgeInsets.symmetric(vertical: 30),
                      width: wid - dialogHorPadding - 30,
                      height: 55,
                      decoration: BoxDecoration(
                        color: Colors.transparent,
                        borderRadius: BorderRadius.circular(14),
                        border: Border.all(
                          color: Colors.grey[400]!,
                          width: 0.5,
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const SizedBox(width: 5),
                          Container(
                            height: 35,
                            width: 35,
                            decoration: const BoxDecoration(
                              image: DecorationImage(
                                scale: 2,
                                image: AssetImage('assets/images/x.jpg'),
                              ),
                              shape: BoxShape.circle,
                            ),
                          ),
                          const SizedBox(width: 15),
                          Expanded(
                            child: Text(
                              selectedFarm.strStakedAlias.value.isNotEmpty
                                  ? stakedAlias
                                  : stakedSymbol,
                              style: textStyle(
                                Colors.white,
                                15,
                                isBold: false,
                                isUline: false,
                              ),
                            ),
                          ),
                          Container(
                            height: 28,
                            width: 48,
                            decoration: boxDecoration(
                              Colors.transparent,
                              100,
                              0.5,
                              Colors.grey[400]!,
                            ),
                            child: TextButton(
                              onPressed: () {
                                unStakeAxInputController.text =
                                    selectedFarm.stakingInfo.value.viewAmount;
                                final inputAmount =
                                    unStakeAxInputController.text;
                                bloc.add(
                                  MaxButtonPressed(
                                    selectedFarm: selectedFarm,
                                    input: inputAmount,
                                  ),
                                );
                              },
                              child: Text(
                                'Max',
                                style: textStyle(
                                  Colors.grey[400]!,
                                  9,
                                  isBold: false,
                                  isUline: false,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 70,
                            child: TextFormField(
                              keyboardType:
                                  const TextInputType.numberWithOptions(
                                decimal: true,
                              ),
                              controller: unStakeAxInputController,
                              onChanged: (value) {
                                bloc.add(
                                  UnStakeInput(
                                    selectedFarm: selectedFarm,
                                    input: value,
                                  ),
                                );
                              },
                              style: textStyle(
                                Colors.grey[400]!,
                                22,
                                isBold: false,
                                isUline: false,
                              ),
                              decoration: InputDecoration(
                                hintText: '0.00',
                                hintStyle: textStyle(
                                  Colors.grey[400]!,
                                  22,
                                  isBold: false,
                                  isUline: false,
                                ),
                                contentPadding: const EdgeInsets.all(9),
                                border: InputBorder.none,
                              ),
                              inputFormatters: [
                                FilteringTextInputFormatter.allow(
                                  RegExp(r'^(\d+)?\.?\d{0,6}'),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Current $stakedSymbol Staked',
                      style: textStyle(
                        Colors.grey[400]!,
                        14,
                        isBold: false,
                        isUline: false,
                      ),
                    ),
                    Text(
                      '''$currentStaked $stakedSymbol''',
                      style: textStyle(
                        Colors.grey[400]!,
                        14,
                        isBold: false,
                        isUline: false,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.only(left: 55),
                      child: Text(
                        '-',
                        style: textStyle(
                          Colors.grey[400]!,
                          14,
                          isBold: false,
                          isUline: false,
                        ),
                      ),
                    )
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Funds Removed',
                      style: textStyle(
                        Colors.grey[400]!,
                        14,
                        isBold: false,
                        isUline: false,
                      ),
                    ),
                    Text(
                      '''$fundsRemoved $stakedSymbol''',
                      style: textStyle(
                        Colors.grey[400]!,
                        14,
                        isBold: false,
                        isUline: false,
                      ),
                    ),
                  ],
                ),
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 10),
                  child: Divider(
                    thickness: 0.35,
                    color: Colors.grey[400],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('New Staked Balance'),
                    Text(
                      '''$newBalance $stakedSymbol''',
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if (status == BlocStatus.success) ...[
                      UnStakeApproveButton(
                        width: 175,
                        height: 45,
                        text: 'Confirm',
                        selectedFarm: selectedFarm,
                        walletAddress: context
                            .read<WalletBloc>()
                            .state
                            .formattedWalletAddress,
                      ),
                    ] else ...[
                      const WarningTextButton(
                        warningTitle: 'Insufficient Balance',
                      ),
                    ]
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
