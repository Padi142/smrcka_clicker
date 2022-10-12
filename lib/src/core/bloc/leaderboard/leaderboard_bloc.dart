import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smrcka_clicker/src/core/bloc/leaderboard/leaderboard_state.dart';
import 'package:smrcka_clicker/src/core/provider/leaderboard_provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'leaderboard_event.dart';

class LeaderboardBloc extends Bloc<LeaderboardEvent, LeaderboardState> {
  LeaderboardBloc() : super(const LeaderboardState.initial()) {
    on<LoadEvent>(_onInitialEvent);
    on<AddScore>(_onAddScore);
    on<CreateScore>(_onCreateScore);
  }

  LeaderboardProvider leaderboardProvider = LeaderboardProvider();

  Future<void> _onInitialEvent(
      LoadEvent event, Emitter<LeaderboardState> emit) async {
    final prefs = await SharedPreferences.getInstance();
    final username = prefs.getString("username");

    final leaderboardList = await leaderboardProvider.loadLeaderboard();
    final userRow = await leaderboardProvider.loadUserRow(username);
    if (leaderboardList != null && userRow != null) {
      emit(LeaderboardState.loaded(username, leaderboardList, userRow));
    }
    if (leaderboardList != null && userRow == null) {
      emit(LeaderboardState.loaded(username, leaderboardList, null));
    }
  }

  Future<void> _onAddScore(
      AddScore event, Emitter<LeaderboardState> emit) async {}

  Future<void> _onCreateScore(
      CreateScore event, Emitter<LeaderboardState> emit) async {
    final supabase = Supabase.instance.client;
    final values = {
      'user_name': event.username,
      'clicks': event.clicks,
      "last_update": DateTime.now().toIso8601String(),
    };

    await supabase.from('leaderboard').insert(values).execute();
  }
}
