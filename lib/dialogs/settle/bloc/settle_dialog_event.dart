part of 'settle_dialog_bloc.dart';

abstract class SettleDialogEvent extends Equatable {
  const SettleDialogEvent();

  @override
  List<Object?> get props => [];
}

class EnableExpiry extends SettleDialogEvent {
  const EnableExpiry();
  @override
  List<Object?> get props => [];
}

class GetSettlePrice extends SettleDialogEvent {
  @override
  List<Object?> get props => [];
}

class SettleAllAPT extends SettleDialogEvent {
  @override
  List<Object?> get props => [];
}

class Expire extends SettleDialogEvent {
  @override
  List<Object?> get props => [];
}
