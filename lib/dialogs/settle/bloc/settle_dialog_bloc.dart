
import 'dart:html';

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
        required LongShortPairRepository longShortPairRepository,
        required TokensRepository tokensRepository,
        required WalletRepository walletRepository,
    }) : _longShortPairRepository = longShortPairRepository, _tokensRepository = tokensRepository, _walletRepository = walletRepository,
    super(const SettleDialogState())
    {
        on((event, emit) => null);
        on((event, emit) => null);
    }
    
    final LongShortPairRepository _longShortPairRepository;
    final TokensRepository _tokensRepository;
    final WalletRepository _walletRepository;




}
