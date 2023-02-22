import 'dart:core';
import 'package:ax_dapp/service/controller/scout/long_short_pair_repository.dart';

bool isAPTExpired() {
    var returnValue = false;
    
    var currentTimestamp = DateTime.now().millisecondsSinceEpoch;
    int expirationTimestamp = await LongShortPairRepository().expTimestamp();

    expirationTimestamp > currentTimestamp ? returnValue = true : returnValue = false;

    return returnValue;
}

