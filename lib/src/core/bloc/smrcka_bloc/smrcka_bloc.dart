import 'dart:math';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smrcka_clicker/src/core/bloc/smrcka_bloc/smrcka_state.dart';
import 'package:smrcka_clicker/src/core/model/pet_model.dart';
import 'package:smrcka_clicker/src/core/provider/leaderboard_provider.dart';

part 'smrcka_event.dart';

class SmrckaBloc extends Bloc<SmrckaEvent, SmrckaState> {
  SmrckaBloc() : super(const SmrckaState.initial()) {
    on<PetEvent>(_onPet);
    on<SmrckaInitialEvent>(_onInitialEvent);
    on<ChangeSkin>(_onChangeSkin);
  }

  LeaderboardProvider leaderboardProvider = LeaderboardProvider();

  Future<void> _onInitialEvent(
      SmrckaInitialEvent event, Emitter<SmrckaState> emit) async {
    final prefs = await SharedPreferences.getInstance();
    int pets = 0;

    int? savedPets = prefs.getInt("pets");
    if (savedPets != null) {
      pets = savedPets;
    }

    emit(SmrckaState.loaded(PetModel(
        pets: pets,
        image: "assets/images/smrckasanta.jpg",
        petImage: "assets/images/smrckasantapat.gif",
        name: "Smrcka")));
  }

  Future<void> _onPet(PetEvent event, Emitter<SmrckaState> emit) async {
    final prefs = await SharedPreferences.getInstance();
    Random rnd = Random();

    emit(SmrckaState.pet(event.pet));

    final int troll = rnd.nextInt(250);
    if (troll <= 5) {
      emit(SmrckaState.troll(event.pet));
      await leaderboardProvider.addSotek();
      await leaderboardProvider.addScore(event.pet.pets - 10);
      await prefs.setInt("pets", event.pet.pets - 10);

      await Future.delayed(const Duration(seconds: 17));
      emit(SmrckaState.loaded(event.pet.copyWith(pets: event.pet.pets - 10)));
    } else {
      await Future.delayed(const Duration(seconds: 2));

      await leaderboardProvider.addScore(event.pet.pets + 1);
      await prefs.setInt("pets", event.pet.pets + 1);
      emit(SmrckaState.loaded(event.pet.copyWith(pets: event.pet.pets + 1)));
    }
  }

  Future<void> _onChangeSkin(
      ChangeSkin event, Emitter<SmrckaState> emit) async {
    emit(const SmrckaState.initial());
    emit(SmrckaState.loaded(
        event.pet.copyWith(image: event.imgSkin, petImage: event.petSkin)));
  }
}
