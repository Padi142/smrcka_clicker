import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smrcka_clicker/src/core/bloc/smrcka_bloc/smrcka_state.dart';
import 'package:smrcka_clicker/src/core/model/pet_model.dart';

part 'smrcka_event.dart';

class SmrckaBloc extends Bloc<SmrckaEvent, SmrckaState> {
  SmrckaBloc() : super(const SmrckaState.initial()) {
    on<PetEvent>(_onPet);
    on<InitialEvent>(_onInitialEvent);
  }

  Future<void> _onInitialEvent(
      InitialEvent event, Emitter<SmrckaState> emit) async {
    emit(const SmrckaState.loaded(
        PetModel(pets: 0, image: "assets/images/smrcka.jpg", name: "Smrcka")));
  }

  Future<void> _onPet(PetEvent event, Emitter<SmrckaState> emit) async {
    emit(SmrckaState.pet(event.pet));
    await Future.delayed(const Duration(seconds: 2));
    emit(SmrckaState.loaded(PetModel(
        name: event.pet.name,
        pets: event.pet.pets + 1,
        image: event.pet.image)));
  }
}
