// ignore_for_file: avoid_dynamic_calls, inference_failure_on_function_invocation

import 'dart:convert';

import 'package:ax_dapp/service/athlete_models/athlete_price_record.dart';
import 'package:ax_dapp/service/athlete_models/nfl/nfl_athlete.dart';
import 'package:ax_dapp/service/athlete_models/price_record.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class NFLAthleteAPI {
  NFLAthleteAPI(this.dio) {
    initState();
  }

  Future<void> initState() async {
    const cidUrl =
        'https://raw.githubusercontent.com/AthleteX-DAO/sports-cids/main/nfl.json';
    final response = await http.get(Uri.parse(cidUrl));
    if (response.statusCode == 200) {
      final decodedData = json.decode(response.body);
      final cid = await decodedData['directory'] as String;
      baseDataUrl = 'https://$cid.ipfs.nftstorage.link';
    } else {
      throw Exception('Failed to fetch data');
    }
  }

  final Dio dio;
  late String baseDataUrl;

  Future<List<NFLAthlete>> getPlayersById(List<int> ids) async {
    final athletes = <NFLAthlete>[];
    for (var i = 0; i < ids.length; i++) {
      final url = '$baseDataUrl/${ids[i]}';
      final jsonString = await dio.get(url);
      final json = jsonDecode(jsonString.toString()) as Map<String, dynamic>;
      final athlete = NFLAthlete.fromJson(json);
      athletes.add(athlete);
    }

    return athletes;
  }

  Future<List<NFLAthlete>> getSupportedPlayers() async {
    final athletes = <NFLAthlete>[];
    final url = '$baseDataUrl/ALL_PLAYERS';
    final jsonString = await dio.get(url);
    final json = jsonDecode(jsonString.toString()) as Map<String, dynamic>;
    final athleteList = json['Athletes'] as List<dynamic>;
    for (final athlete in athleteList) {
      athletes.add(
        NFLAthlete.fromPartialJson(athlete as Map<String, dynamic>),
      );
    }
    return athletes;
  }

  Future<NFLAthlete> getPlayer(int id) async {
    final url = '$baseDataUrl/$id';
    return NFLAthlete.fromJson(
      dio.get(url) as Map<String, dynamic>,
    );
  }

  Future<List<NFLAthlete>> getPlayersByPosition(String position) async {
    final athletes = <NFLAthlete>[];
    final url = '$baseDataUrl/ALL_PLAYERS';
    final jsonString = dio.get(url) as String;

    try {
      final jsonData = jsonDecode(jsonString) as Map<String, dynamic>;
      final athletesData = jsonData['Athletes'] as List<dynamic>;
      for (final athlete in athletesData) {
        final athPosition = athlete['Position'].toString().toLowerCase();
        if (athPosition.contains(position.toLowerCase())) {
          athletes.add(NFLAthlete.fromJson(athlete as Map<String, dynamic>));
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error decoding JSON: $e');
      }
    }

    return athletes;
  }

  Future<AthletePriceRecord> getPlayerPriceHistory(
    int id,
    String from,
    String until,
    String interval,
  ) async {
    // valid intervals: Hour, Day
    String caseInterval;
    interval.toLowerCase() == 'hour'
        ? caseInterval = 'Hour'
        : caseInterval = 'Day';

    final url = '$baseDataUrl/${id}_history';
    final jsonString = dio.get(url) as String;
    final history = <PriceRecord>[];
    final fromTime = DateTime.parse(from);
    final untilTime = DateTime.parse(until);

    try {
      final jsonData = jsonDecode(jsonString) as Map<String, dynamic>;
      final historyData = jsonData[caseInterval] as List<dynamic>;
      for (final priceTime in historyData) {
        final time = DateTime.parse(priceTime['Time'] as String);
        if (time.compareTo(fromTime) <= 0 && time.compareTo(untilTime) >= 0) {
          history.add(
            PriceRecord(
              price: double.parse(priceTime['Price'] as String),
              timestamp: time.toString(),
            ),
          );
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error decoding JSON: $e');
      }
    }

    return AthletePriceRecord(
      id: id,
      name: '',
      priceHistory: history,
    );
  }

  Future<List<AthletePriceRecord>> getPlayersPriceHistory(
    List<int> playerIds,
    String from,
    String until,
    String interval,
  ) async {
    final playersHistory = <AthletePriceRecord>[];
    for (final id in playerIds) {
      playersHistory
          .add(await getPlayerPriceHistory(id, from, until, interval));
    }

    return playersHistory;
  }
}
