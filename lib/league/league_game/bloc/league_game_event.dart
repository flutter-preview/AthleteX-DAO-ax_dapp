part of 'league_game_bloc.dart';

abstract class LeagueGameEvent extends Equatable {
  const LeagueGameEvent();

  @override
  List<Object?> get props => [];
}

class WatchAppDataChangesStarted extends LeagueGameEvent {
  const WatchAppDataChangesStarted();
}

class FetchScoutInfoRequested extends LeagueGameEvent {}

class EditTeamsEvent extends LeagueGameEvent {
  const EditTeamsEvent({
    required this.rosters,
    required this.sports,
    required this.teamSize,
  });

  final String rosters;
  final String sports;
  final String teamSize;

  @override
  List<Object?> get props => [rosters, sports, teamSize];
}

class ClaimPrizeEvent extends LeagueGameEvent {}

class CalculateAppreciationEvent extends LeagueGameEvent {
  const CalculateAppreciationEvent({
    required this.rosters,
    required this.athletes,
  });

  final Map<String, Map<String, double>> rosters;
  final List<AthleteScoutModel> athletes;

  @override
  List<Object?> get props => [rosters, athletes];
}

class JoinLeagueEvent extends LeagueGameEvent {
  const JoinLeagueEvent({
    required this.leagueID,
    required this.entryFee,
    required this.isPrivate,
  });

  final String leagueID;
  final String entryFee;
  final String isPrivate;

  @override
  List<Object?> get props => [leagueID, entryFee, isPrivate];
}

class LeaveLeagueEvent extends LeagueGameEvent {}

class CalculateRemainingDays extends LeagueGameEvent {}
