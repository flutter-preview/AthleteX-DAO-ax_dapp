import 'package:ax_dapp/scout/models/models.dart';
import 'package:ax_dapp/service/tracking/tracking_cubit.dart';
import 'package:ax_dapp/wallet/bloc/wallet_bloc.dart';
import 'package:flutter/material.dart';
import 'package:ax_dapp/service/confirmation_dialogs/custom_confirmation_dialogs.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SettleApproveButton extends StatefulWidget {
  const SettleApproveButton({
    required this.width,
    required this.height,
    required this.text,
    required this.athlete,
    required this.approveCallback,
    required this.confirmCallback,
    super.key,
  });

  final double width;
  final double height;
  final String text;
  final AthleteScoutModel athlete;

  final Future<void> Function() approveCallback;
  final Future<void> Function() confirmCallback;

  @override
  State<SettleApproveButton> createState() => _SettleApproveButtonState();
}

class _SettleApproveButtonState extends State<SettleApproveButton> {
  double width = 0;
  double height = 0;
  String text = '';
  bool isApproved = false;
  Color? fillColor;
  Color? textColor;

  @override
  void initState() {
    super.initState();
    width = widget.width;
    height = widget.height;
    text = widget.text;
    fillColor = Colors.transparent;
    textColor = Colors.amber;
  }

  void changeButton() {
    // Changes from approbe to waiting
    setState(() {
      text = 'Waiting for Approval';
      fillColor = Colors.grey;
      textColor = Colors.black;
    });
    //Changes from approve button to confirm
    widget.approveCallback().then((_) {
      setState(() {
        isApproved = true;
        text = 'Confirm';
        fillColor = Colors.amber;
        textColor = Colors.black;
      });
    }).catchError((_) {
      showDialog<void>(
        context: context,
        builder: (context) => const FailedDialog(),
      ).then((value) {
        if (mounted) {
          Navigator.pop(context);
        }
      });
      setState(() {
        isApproved = false;
        text = 'Approve';
        fillColor = Colors.transparent;
        textColor = Colors.amber;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.amber),
        color: fillColor,
        borderRadius: BorderRadius.circular(100),
      ),
      child: TextButton(
        onPressed: () {
          final walletAddress =
              context.read<WalletBloc>().state.formattedWalletAddress;
          widget.confirmCallback();
        },
        child: Text(
          'Settle',
          style: TextStyle(
            fontSize: 16,
            color: textColor,
            fontFamily: 'OpenSans',
          ),
        ),
      ),
    );
  }
}
