import 'package:ax_dapp/service/controller/scout/long_short_pair_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:ax_dapp/util/bloc_status.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tokens_repository/tokens_repository.dart';
import 'package:wallet_repository/wallet_repository.dart';

part 'settle_dialog_event.dart';
part 'settle_dialog_state.dart';

class SettleDialogBloc extends Bloc<SettleDialogEvent, SettleDialogState> {
  SettleDialogBloc({
    required this.longShortPairRepository,
    required TokensRepository tokensRepository,
    required WalletRepository walletRepository,
  })  : _tokensRepository = tokensRepository,
        _walletRepository = walletRepository,
        super(const SettleDialogState()) {
    on<EnableExpiry>(_onEnableExpiry);
    on<GetSettlePrice>(_onGetSettlePrice);

    // Immediately get the settlement price after invocation
    add(GetSettlePrice());
  }

  final LongShortPairRepository longShortPairRepository;
  final TokensRepository _tokensRepository;
  final WalletRepository _walletRepository;

  Future<void> _onEnableExpiry(
    EnableExpiry event,
    Emitter<SettleDialogState> emit,
  ) async {
    emit(
      state.copyWith(longAPTAmount: 0, shortAPTAmount: 0),
    );
    add(GetSettlePrice());
  }

  Future<void> _onGetSettlePrice(
    GetSettlePrice event,
    Emitter<SettleDialogState> emit,
  ) async {
    final settlementPrice = await longShortPairRepository.expPrice();

    emit(
      state.copyWith(settlementPrice: settlementPrice),
    );
  }
}
