import 'package:ax_dapp/repositories/sports_repo.dart';
import 'package:ax_dapp/service/api/models/player_ids.dart';
import 'package:ax_dapp/service/api/nfl_athlete_api.dart';
import 'package:ax_dapp/service/athlete_models/athlete_price_record.dart';
import 'package:ax_dapp/service/athlete_models/nfl/nfl_athlete.dart';
import 'package:ax_dapp/service/athlete_models/nfl/nfl_athlete_stats.dart';
// ignore: don't_import_implementation_files
import 'package:ethereum_api/src/config/models/apts/nfl_apt_list.dart';
import 'package:tokens_repository/tokens_repository.dart';

class NFLRepo extends SportsRepo<NFLAthlete> {
  NFLRepo(NFLAthleteAPI api)
      : _api = api,
        super(SupportedSport.NFL);
  final NFLAthleteAPI _api;

  @override
  Future<List<NFLAthlete>> getAllPlayers() async {
    return _api.getAllPlayers();
  }

  @override
  Future<List<NFLAthlete>> getPlayersById(List<int> ids) async {
    return _api.getPlayersById(ids);
  }

  @override
  Future<List<NFLAthlete>> getSupportedPlayers() async {
    return _api.getAllPlayers();
  }

  @override
  Future<NFLAthlete> getPlayer(int id) async {
    return _api.getPlayer(id);
  }

  @override
  Future<List<NFLAthlete>> getPlayersByTeam(String team) async {
    return _api.getPlayersByTeam(team);
  }

  @override
  Future<List<NFLAthlete>> getPlayersByPosition(String position) async {
    return _api.getPlayersByPosition(position);
  }

  @override
  Future<List<NFLAthlete>> getPlayersByTeamAtPosition(
    String team,
    String position,
  ) async {
    return _api.getPlayersByTeamAtPosition(team, position);
  }

  @override
  Future<NFLAthleteStats> getPlayerStatsHistory(
    int id,
    String from,
    String until,
  ) async {
    return _api.getPlayerHistory(id, from, until);
  }

  @override
  Future<AthletePriceRecord> getPlayerPriceHistory(
    int id, {
    String? from,
    String? until,
    String? interval,
  }) {
    return _api.getPlayerPriceHistory(id, from, until, interval ?? '1d');
  }

  @override
  Future<List<NFLAthleteStats>> getPlayersStatsHistory(
    List<int> ids,
    String from,
    String until,
  ) async {
    final list = _api.getPlayersHistory(ids, from, until);
    return list;
  }

  @override
  Future<List<AthletePriceRecord>> getPlayersPriceHistory(
    List<int> ids, {
    String? from,
    String? until,
    String? interval,
  }) async {
    final list =
        _api.getPlayersPriceHistory(ids, from, until, interval ?? '1d');
    return list;
  }
}
