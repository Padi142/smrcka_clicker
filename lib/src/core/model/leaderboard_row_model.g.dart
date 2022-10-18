// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'leaderboard_row_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LeaderboardRowModel _$LeaderboardRowModelFromJson(Map<String, dynamic> json) =>
    LeaderboardRowModel(
      username: json['User_name'] as String,
      clicks: json['Clicks'] as int,
      sotekCount: json['Sotek_count'] as int,
    );

Map<String, dynamic> _$LeaderboardRowModelToJson(
        LeaderboardRowModel instance) =>
    <String, dynamic>{
      'User_name': instance.username,
      'Clicks': instance.clicks,
      'Sotek_count': instance.sotekCount,
    };
