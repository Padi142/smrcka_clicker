import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:smrcka_clicker/src/core/model/leaderboard_row_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:dio/dio.dart';

class LeaderboardProvider {
  String url = "https://smrckaclicker-production.up.railway.app";
  Future<List<LeaderboardRowModel>?> loadLeaderboard() async {
    try {
      var dio = Dio();

      Response response = await dio.get("$url/users");

      return (response.data as List<dynamic>)
          .map((it) => LeaderboardRowModel.fromJson(it))
          .toList();
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future<LeaderboardRowModel?> loadUserRow(String? username) async {
    if (username == null) {
      return null;
    }
    try {
      var dio = Dio();

      Response response = await dio.get("$url/getUser?username=$username");

      return LeaderboardRowModel.fromJson(response.data);
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future<void> addScore(int clicks) async {
    final prefs = await SharedPreferences.getInstance();

    final username = prefs.getString("nick");

    if (username != null) {
      try {
        var dio = Dio();

        await dio.get("$url/addScore?username=$username&clicks=$clicks");
      } catch (e) {
        print(e);
      }
    }
  }

  Future<void> addSotek() async {
    try {
      var dio = Dio();
      final prefs = await SharedPreferences.getInstance();
      final nick = prefs.getString("nick");
      if (nick != null) {
        await dio.get("$url/addSotek?username$nick");
      }
    } catch (e) {
      print(e);
    }
  }
}
