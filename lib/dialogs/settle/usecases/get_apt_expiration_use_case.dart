import 'dart:core';
import 'package:ax_dapp/service/controller/scout/long_short_pair_repository.dart';

class GetAPTExpirationUseCase {
  GetAPTExpirationUseCase({
    required LongShortPairRepository longShortPairRepository,
    required this.address,
  }) : _longShortPairRepository = longShortPairRepository;

  final LongShortPairRepository _longShortPairRepository;
  final String address;

  Future<bool> isAptExpired() async {
    final currentTimestamp = DateTime.now().millisecondsSinceEpoch;
    final aptTimestamp = await _longShortPairRepository.expTimestamp();
    return currentTimestamp > aptTimestamp;
  }
}
