part of 'athlete_page_bloc.dart';

class AthletePageState extends Equatable {
  const AthletePageState({
    this.status = BlocStatus.initial,
    this.aptTypeSelection = AptType.long,
    this.longApt = const Apt.empty(),
    this.shortApt = const Apt.empty(),
    this.stats = const [],
    this.failure = Failure.none,
    this.isExpired = false,
  });

  final BlocStatus status;
  final AptType aptTypeSelection;
  final Apt longApt;
  final Apt shortApt;
  final List<GraphData> stats;
  final Failure failure;
  final bool isExpired;

  AthletePageState copyWith({
    BlocStatus? status,
    AptType? aptTypeSelection,
    Apt? longApt,
    Apt? shortApt,
    List<GraphData>? stats,
    Failure? failure,
    bool? isExpired,
  }) {
    return AthletePageState(
      status: status ?? this.status,
      aptTypeSelection: aptTypeSelection ?? this.aptTypeSelection,
      longApt: longApt ?? this.longApt,
      shortApt: shortApt ?? this.shortApt,
      stats: stats ?? this.stats,
      failure: failure ?? this.failure,
      isExpired: isExpired ?? this.isExpired,
    );
  }

  @override
  List<Object?> get props =>
      [status, aptTypeSelection, longApt, shortApt, stats, failure, isExpired];
}

extension BuyDialogStateX on AthletePageState {
  String get selectedAptAddress =>
      aptTypeSelection.isLong ? longApt.address : shortApt.address;
}

class InvalidAthleteFailure extends Failure {
  /// {macor temp_failure}
  InvalidAthleteFailure()
      : super(Exception('Athlete not Found'), StackTrace.empty);
}
