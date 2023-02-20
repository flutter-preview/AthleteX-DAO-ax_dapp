part of 'settle_dialog_bloc.dart';

class SettleDialogState extends Equatable {
    const SettleDialogState({
    this.aptPair = AptPair.empty,
    this.longApt = const Apt.empty(),
    this.shortApt = const Apt.empty(),
    this.longBalance = 0,
    this.shortBalance = 0,
    this.shortRedeemInput = 0,
    this.longRedeemInput = 0,
    this.receiveAmount = 0,
    this.status = BlocStatus.initial,
    this.errorMessage = '',
    this.failure = Failure.none,
    this.spendAmount = 0,
    this.collateralPerPair = 0,
    this.smallestBalance = 0,
    });

  final AptPair aptPair;
  final Apt longApt;
  final Apt shortApt;
  final double longBalance;
  final double shortBalance;
  final double shortRedeemInput;
  final double longRedeemInput;
  final double receiveAmount;
  final BlocStatus status;
  final String errorMessage;
  final Failure failure;
  final double spendAmount;
  final int collateralPerPair;
  final double smallestBalance;

    

}