import 'package:ax_dapp/scout/models/athlete_scout_model.dart';

class MLBAthleteScoutModel extends AthleteScoutModel {
  const MLBAthleteScoutModel({
    required super.id,
    required super.name,
    required super.position,
    required super.team,
    required double super.longTokenBookPrice,
    required double super.longTokenBookPriceUsd,
    required double super.longTokenBookPricePercent,
    required double super.shortTokenBookPrice,
    required double super.shortTokenBookPriceUsd,
    required double super.shortTokenBookPricePercent,
    required super.sport,
    required super.time,
    required double super.longTokenPrice,
    required double super.shortTokenPrice,
    required double super.longTokenPercentage,
    required double super.shortTokenPercentage,
    required double super.longTokenPriceUsd,
    required double super.shortTokenPriceUsd,
    required this.homeRuns,
    required this.strikeOuts,
    required this.saves,
    required this.stolenBases,
    required this.atBats,
    required this.weightedOnBasePercentage,
    required this.errors,
  });

  final double homeRuns;
  final double strikeOuts;
  final double saves;
  final double stolenBases;
  final double atBats;
  final double weightedOnBasePercentage;
  final double errors;

  @override
  List<Object?> get props => super.props
    ..addAll([
      homeRuns,
      strikeOuts,
      saves,
      stolenBases,
      atBats,
      weightedOnBasePercentage,
      errors,
    ]);
}
