// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'leaderboard_row_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LeaderboardRowModel _$LeaderboardRowModelFromJson(Map<String, dynamic> json) =>
    LeaderboardRowModel(
      username: json['user_name'] as String,
      clicks: json['clicks'] as int,
      sotekCount: json['sotek_count'] as int,
    );

Map<String, dynamic> _$LeaderboardRowModelToJson(
        LeaderboardRowModel instance) =>
    <String, dynamic>{
      'user_name': instance.username,
      'clicks': instance.clicks,
      'sotek_count': instance.sotekCount,
    };
