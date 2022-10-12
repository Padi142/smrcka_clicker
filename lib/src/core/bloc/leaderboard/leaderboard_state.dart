// ignore: depend_on_referenced_packages
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:smrcka_clicker/src/core/model/leaderboard_row_model.dart';

part 'leaderboard_state.freezed.dart';

@freezed
class LeaderboardState with _$LeaderboardState {
  const factory LeaderboardState.initial() = Initial;
  const factory LeaderboardState.error() = Error;
  const factory LeaderboardState.loaded(
      String? username,
      List<LeaderboardRowModel> sortedBoard,
      LeaderboardRowModel? myPosition) = Loaded;
}
