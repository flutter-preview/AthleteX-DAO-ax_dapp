part of 'settle_dialog_bloc.dart';

class SettleDialogState extends Equatable {
  const SettleDialogState({
    this.status = BlocStatus.initial,
    this.settlementPrice = 1000,
    this.settlementTime = 0,
    this.longAPTAmount = 0,
    this.shortAPTAmount = 0,
  });

  final double longAPTAmount;
  final double shortAPTAmount;
  final double settlementPrice;
  final int settlementTime;
  final BlocStatus status;

  @override
  List<Object> get props {
    return [
      settlementPrice,
      longAPTAmount,
      shortAPTAmount,
      status,
    ];
  }

  SettleDialogState copyWith({
    double? settlementPrice,
    int? settlementTime,
    double? longAPTAmount,
    double? shortAPTAmount,
    BlocStatus? status,
  }) {
    return SettleDialogState(
      settlementPrice: settlementPrice ?? this.settlementPrice,
      longAPTAmount: longAPTAmount ?? this.longAPTAmount,
      shortAPTAmount: shortAPTAmount ?? this.shortAPTAmount,
      status: status ?? this.status,
    );
  }
}
