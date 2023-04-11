import 'package:ax_dapp/service/athlete_models/athlete_price_record.dart';
import 'package:tokens_repository/tokens_repository.dart';

abstract class SportsRepo<SportAthlete> {
  SportsRepo(this.sport);

  final SupportedSport sport;

  Future<List<SportAthlete>> getPlayersById(List<int> ids);

  Future<List<SportAthlete>> getSupportedPlayers();

  Future<SportAthlete> getPlayer(int id);

  Future<List<SportAthlete>> getPlayersByPosition(String position);

  Future<AthletePriceRecord> getPlayerPriceHistory(
    int id, {
    String? from,
    String? until,
    String? interval,
  });

  Future<List<AthletePriceRecord>> getPlayersPriceHistory(
    List<int> ids, {
    String? from,
    String? until,
    String? interval,
  });
}
