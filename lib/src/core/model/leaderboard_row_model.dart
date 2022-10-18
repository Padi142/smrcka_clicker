import 'package:equatable/equatable.dart';
// ignore: depend_on_referenced_packages
import 'package:json_annotation/json_annotation.dart';

part 'leaderboard_row_model.g.dart';

@JsonSerializable()
class LeaderboardRowModel extends Equatable {
  @JsonKey(name: 'User_name')
  final String username;
  @JsonKey(name: 'Clicks')
  final int clicks;
  @JsonKey(name: 'Sotek_count')
  final int sotekCount;

  const LeaderboardRowModel(
      {required this.username, required this.clicks, required this.sotekCount});
  @override
  List<Object?> get props => [username, clicks, sotekCount];

  factory LeaderboardRowModel.fromJson(Map<String, dynamic> json) =>
      _$LeaderboardRowModelFromJson(json);

  Map<String, dynamic> toJson() => _$LeaderboardRowModelToJson(this);
}
