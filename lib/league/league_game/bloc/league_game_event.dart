part of 'league_game_bloc.dart';

abstract class LeagueGameEvent extends Equatable {
  const LeagueGameEvent();

  @override
  List<Object?> get props => [];
}

class InviteEvent extends LeagueGameEvent {
  const InviteEvent({
    required this.leagueID,
    required this.isPrivate,
  });

  final String leagueID;
  final String isPrivate;

  @override
  List<Object?> get props => [leagueID, isPrivate];
}

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

class TimerEvent extends LeagueGameEvent {
  const TimerEvent({
    required this.startDate,
    required this.endDate,
  });

  final String startDate;
  final String endDate;

  @override
  List<Object?> get props => [startDate, endDate];
}

class CalculateAppreciationEvent extends LeagueGameEvent {}

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
