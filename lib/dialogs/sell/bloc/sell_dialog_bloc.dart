// ignore_for_file: implementation_imports

import 'dart:async';

import 'package:ax_dapp/repositories/subgraph/usecases/get_sell_info_use_case.dart';
import 'package:ax_dapp/service/blockchain_models/apt_sell_info.dart';
import 'package:ax_dapp/service/controller/swap/swap_repository.dart';
import 'package:ax_dapp/service/controller/usecases/get_max_token_input_use_case.dart';
import 'package:ax_dapp/util/bloc_status.dart';
import 'package:ethereum_api/src/tokens/models/contract.dart';
import 'package:shared/shared.dart';
import 'package:tokens_repository/tokens_repository.dart';
import 'package:use_cases/stream_app_data_changes_use_case.dart';
import 'package:wallet_repository/wallet_repository.dart';

part 'sell_dialog_event.dart';
part 'sell_dialog_state.dart';

const String noTokenInfoMessage = 'There is no detailed data for this token.';
const String exceptionMessage =
    'There is an exception for the action of this token';

class SellDialogBloc extends Bloc<SellDialogEvent, SellDialogState> {
  SellDialogBloc({
    required TokensRepository tokensRepository,
    required WalletRepository walletRepository,
    required StreamAppDataChangesUseCase streamAppDataChanges,
    required this.repo,
    required this.wallet,
    required this.swapRepository,
    required int athleteId,
  })  : _streamAppDataChanges = streamAppDataChanges,
        _walletRepository = walletRepository,
        _tokensRepository = tokensRepository,
        super(
          // setting the apt corresponding to the default aptType which is long
          SellDialogState(
            longApt: tokensRepository.currentAptPair(athleteId).longApt,
          ),
        ) {
    on<WatchAptPairStarted>(_onWatchAptPairStarted);
    on<AptTypeSelectionChanged>(_onAptTypeSelectionChanged);
    on<FetchAptSellInfoRequested>(_onFetchAptSellInfoRequested);
    on<MaxSellTap>(_mapMaxSellTapEventToState);
    on<ConfirmSell>(_mapConfirmSellEventToState);
    on<NewAptInput>(_mapNewAptInputEventToState);
    on<UpdateSwapController>(_mapUpdateSwapControllerEventToState);


    add(WatchAptPairStarted(athleteId));
    add(const FetchAptSellInfoRequested());
  }

  final TokensRepository _tokensRepository;
  final GetSellInfoUseCase repo;
  final GetTotalTokenBalanceUseCase wallet;
  final SwapRepository swapRepository;
  final WalletRepository _walletRepository;
  final StreamAppDataChangesUseCase _streamAppDataChanges;

  Future<void> _onWatchAptPairStarted(
    WatchAptPairStarted event,
    Emitter<SellDialogState> emit,
  ) async {
    await emit.onEach<AptPair>(
      _tokensRepository.aptPairChanges(event.athleteId),
      onData: (aptPair) {
        emit(
          state.copyWith(longApt: aptPair.longApt, shortApt: aptPair.shortApt),
        );
        add(const UpdateSwapController());
      },
    );
  }

  Future<void> _mapUpdateSwapControllerEventToState (
    UpdateSwapController event,
    Emitter<SellDialogState> emit,
  ) async {
    await emit.onEach<AppData>(
      _streamAppDataChanges.appDataChanges,
      onData: (appData) {
        final appConfig = appData.appConfig;
        swapRepository
          ..aptFactory = appConfig.reactiveAptFactoryClient.value
          ..aptRouter = appConfig.reactiveAptRouterClient.value;
        swapRepository.controller.credentials =
            _walletRepository.credentials.value;
        swapRepository.factoryAddress.value = Contract.exchangeFactory(appData.chain).address;
        swapRepository.routerAddress.value = Contract.exchangeRouter(appData.chain).address;
        add(const FetchAptSellInfoRequested());
      },
    );
  }

  void _onAptTypeSelectionChanged(
    AptTypeSelectionChanged event,
    Emitter<SellDialogState> emit,
  ) {
    emit(state.copyWith(aptTypeSelection: event.aptType));
    add(const FetchAptSellInfoRequested());
  }

  Future<void> _onFetchAptSellInfoRequested(
    FetchAptSellInfoRequested event,
    Emitter<SellDialogState> emit,
  ) async {
    emit(state.copyWith(status: BlocStatus.loading));
    try {
      final selectedTokenAddress = state.selectedAptAddress;
      final response =
          await repo.fetchAptSellInfo(aptAddress: selectedTokenAddress);
      final isSuccess = response.isLeft();
      final balance =
          await wallet.getTotalBalanceForToken(selectedTokenAddress);

      if (isSuccess) {
        swapRepository
          ..fromAddress = selectedTokenAddress
          ..toAddress = _tokensRepository.currentTokens.axt.address;
        final swapInfo = response.getLeft().toNullable()!.sellInfo;
        //do some math
        emit(
          state.copyWith(
            balance: balance,
            status: BlocStatus.success,
            aptSellInfo: AptSellInfo(
              axPrice: swapInfo.toPrice,
              minimumReceived: swapInfo.minimumReceived,
              priceImpact: swapInfo.priceImpact,
              receiveAmount: swapInfo.receiveAmount,
              totalFee: swapInfo.totalFee,
            ),
          ),
        );
      } else {
        // TODO(anyone): Create User facing error messages https://athletex.atlassian.net/browse/AX-466
        emit(
          state.copyWith(
            balance: balance,
            status: BlocStatus.noData,
            errorMessage: noTokenInfoMessage,
            aptSellInfo: AptSellInfo.empty,
          ),
        );
      }
    } catch (_) {
      emit(
        state.copyWith(
          status: BlocStatus.error,
          errorMessage: exceptionMessage,
          aptSellInfo: AptSellInfo.empty,
        ),
      );
    }
  }

  Future<void> _mapMaxSellTapEventToState(
    MaxSellTap event,
    Emitter<SellDialogState> emit,
  ) async {
    emit(state.copyWith(status: BlocStatus.loading));
    try {
      final maxInput =
          await wallet.getTotalBalanceForToken(state.selectedAptAddress);
      emit(
        state.copyWith(aptInputAmount: maxInput, status: BlocStatus.success),
      );
      add(NewAptInput(aptInputAmount: maxInput));
    } catch (_) {
      // TODO(anyone): Create User facing error messages https://athletex.atlassian.net/browse/AX-466
      emit(
        state.copyWith(
          status: BlocStatus.error,
          errorMessage: exceptionMessage,
        ),
      );
    }
  }

  void _mapConfirmSellEventToState(
    ConfirmSell event,
    Emitter<SellDialogState> emit,
  ) {}

  Future<void> _mapNewAptInputEventToState(
    NewAptInput event,
    Emitter<SellDialogState> emit,
  ) async {
    final aptInputAmount = event.aptInputAmount;
    try {
      final selectedTokenAddress = state.selectedAptAddress;
      final balance =
          await wallet.getTotalBalanceForToken(selectedTokenAddress);
      final response = await repo.fetchAptSellInfo(
        aptAddress: selectedTokenAddress,
        aptInput: aptInputAmount,
      );
      final isSuccess = response.isLeft();

      if (isSuccess) {
        final swapInfo = response.getLeft().toNullable()!.sellInfo;
        if (aptInputAmount > balance) {
          emit(state.copyWith(
              status: BlocStatus.error,
              failure: InSufficientFailure(),
              errorMessage: 'Insufficient balance'));
        } else {
          if (swapRepository.amount1.value != aptInputAmount) {
            swapRepository.fromAmount = aptInputAmount;
          }
          emit(
            state.copyWith(
              balance: balance,
              status: BlocStatus.success,
              aptSellInfo: AptSellInfo(
                axPrice: swapInfo.toPrice,
                minimumReceived: swapInfo.minimumReceived,
                priceImpact: swapInfo.priceImpact,
                receiveAmount: swapInfo.receiveAmount,
                totalFee: swapInfo.totalFee,
              ),
            ),
          );
        }
      } else {
        // TODO(anyone): Create User facing error messages https://athletex.atlassian.net/browse/AX-466
        emit(
          state.copyWith(
            status: BlocStatus.noData,
            errorMessage: noTokenInfoMessage,
            aptSellInfo: AptSellInfo.empty,
          ),
        );
      }
    } catch (e) {
      emit(
        state.copyWith(
          status: BlocStatus.error,
          errorMessage: exceptionMessage,
          aptSellInfo: AptSellInfo.empty,
        ),
      );
    }
  }
}
