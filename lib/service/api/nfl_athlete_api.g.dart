// part of 'nfl_athlete_api.dart';

// class _NFLAthleteAPI implements NFLAthleteAPI {
//   _NFLAthleteAPI(this._dio) {}

//   final Dio _dio;
//   final baseDataUrl = 'https://${nflApiDataUrl}.ipfs.nftstorage.link';

//   @override
//   Future<List<NFLAthlete>> getPlayersById(ids) async {

//     List<NFLAthlete> athletes = [];
//     for (int i = 0; i < ids.length; i++) {
//       String url = baseDataUrl + '/${ids[i]}';
//       await athletes.add(
//         NFLAthlete.fromJson(
//           _dio.get(url);
//         );
//       );
//     }

//     return await athletes;
//   }

//   @override
//   Future<NFLAthlete> getPlayer(id) async {}
//   //   return await NFLAthlete.fromJson(
//   //     _dio.get(baseDataUrl + '/${id}');
//   //   );
//   // }

//   @override
//   Future<List<NFLAthlete>> getPlayersByPosition(position) async {}
//   //   final List<NFLAthlete> athletes = [];
//   //   final jsonString = _dio.get(baseDataUrl + '/ALL_PLAYERS');
//   //   final Map<String, dynamic> jsonData = jsonDecode(jsonString);
//   //   for (final athlete in jsonData['Athletes']) {
//   //     final String ath_position = athlete['Position'].toString().toLowerCase();
//   //     if (ath_position.contains(position.toLowerCase())) {
//   //       athletes.add(NFLAthlete.fromJson(athlete));
//   //     }
//   //   }

//   //   return athletes;
//   // }

//   @override
//   Future<AthletePriceRecord> getPlayerPriceHistory(
//       id, from, until, interval) async {}
//   //   // valid intervals: Hour, Day
//   //   String case_interval;
//   //   interval.toLowerCase() == 'hour'
//   //     ? case_interval = 'Hour'
//   //     : case_interval = 'Day'

//   //   final jsonString = _dio.get(baseDataUrl + '/${id}_history');
//   //   List<PriceRecord> history;
//   //   DateTime fromTime = DateTime.parse(from);
//   //   DateTime untilTime = DateTime.parse(until);
//   //   for (final priceTime in jsonString[case_interval]) {
//   //     final time = DateTime.parse(priceTime['Time']);
//   //     if (time.compareTo(fromTime) <= 0 && time.compareTo(untilTime) >= 0) {
//   //       history.add(
//   //         PriceRecord(
//   //           price: priceTime['Price'],
//   //           timestamp: time,
//   //         );
//   //       );
//   //     }
//   //   }

//   //   return AthletePriceRecord(
//   //     id: id,
//   //     name: '';
//   //     priceHistory: history,
//   //   );
//   // }

//   @override
//   Future<List<AthletePriceRecord>> getPlayersPriceHistory(
//       playerIds, from, until, interval) async {}
//   //   List<AthletePriceRecord> playersHistory;
//   //   for (final id in playerIds) {
//   //     playersHistory.add(
//   //       getPlayerPriceHistory(id, from, until, interval)
//   //     );
//   //   }

//   //   return playersHistory;
//   // }
// }
