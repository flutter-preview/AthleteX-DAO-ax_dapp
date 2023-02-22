part of 'settle_dialog_bloc.dart';

class SettleDialogState extends Equatable {

  const SettleDialogState({
    this.status = BlocStatus.initial,
    this.longAPTAmount = 0,
    this.shortAPTAmount = 0,
  });

  final double longAPTAmount;
  final double shortAPTAmount;
  final BlocStatus status;
  
  @override
  List<Object> get props {
    return [
      longAPTAmount,
      shortAPTAmount,
      status,
    ];
  }

  SettleDialogState copyWith({
    double? longAPTAmount,
    double? shortAPTAmount,
    BlocStatus? status,
  }) {
    return SettleDialogState(
      longAPTAmount: longAPTAmount ?? this.longAPTAmount,
      shortAPTAmount: shortAPTAmount ?? this.shortAPTAmount,
      status: status ?? this.status,
    );
  }
}
