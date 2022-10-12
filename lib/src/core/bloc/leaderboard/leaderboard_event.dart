part of 'leaderboard_bloc.dart';

abstract class LeaderboardEvent extends Equatable {
  const LeaderboardEvent();

  @override
  List<Object> get props => [];
}

class LoadEvent extends LeaderboardEvent {
  const LoadEvent();

  @override
  List<Object> get props => [];
}

class AddScore extends LeaderboardEvent {
  final String username;
  final int clicks;
  const AddScore(this.username, this.clicks);

  @override
  List<Object> get props => [];
}

class CreateScore extends LeaderboardEvent {
  final String username;
  final int clicks;
  const CreateScore(this.username, this.clicks);

  @override
  List<Object> get props => [];
}
