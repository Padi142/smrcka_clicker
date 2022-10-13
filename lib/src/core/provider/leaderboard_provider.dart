import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:smrcka_clicker/src/core/model/leaderboard_row_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class LeaderboardProvider {
  Future<List<LeaderboardRowModel>?> loadLeaderboard() async {
    final supabase = Supabase.instance.client;

    final leaderboardResponse = await supabase
        .from('leaderboard')
        .select()
        .order("clicks")
        .limit(15)
        .execute();

    if (leaderboardResponse.hasError) {
      return null;
    }
    if (leaderboardResponse.data == null) {
      return null;
    }
    return (leaderboardResponse.data as List<dynamic>)
        .map((it) => LeaderboardRowModel.fromJson(it))
        .toList();
  }

  Future<LeaderboardRowModel?> loadUserRow(String? username) async {
    if (username == null) {
      return null;
    }
    final supabase = Supabase.instance.client;

    final leaderboardResponse = await supabase
        .from('leaderboard')
        .select()
        .eq("user_name", username)
        .single()
        .execute();

    if (leaderboardResponse.hasError) {
      return null;
    }
    if (leaderboardResponse.data == null) {
      return null;
    }
    return LeaderboardRowModel.fromJson(leaderboardResponse.data);
  }

  Future<void> addScore(int clicks) async {
    final supabase = Supabase.instance.client;
    final prefs = await SharedPreferences.getInstance();

    final username = prefs.getString("nick");

    if (username != null) {
      final values = {
        'last_update': DateTime.now().toIso8601String(),
        'clicks': clicks,
      };

      await supabase
          .from('leaderboard')
          .update(values)
          .eq("user_name", username)
          .execute();
    }
  }

  Future<void> addSotek() async {
    final supabase = Supabase.instance.client;
    final prefs = await SharedPreferences.getInstance();
    final nick = prefs.getString("nick");
    if (nick != null) {
      await supabase.rpc('increment', params: {"x": 1, "u": nick}).execute();
    }
  }
}
