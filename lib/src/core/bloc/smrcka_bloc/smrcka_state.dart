// ignore: depend_on_referenced_packages
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:smrcka_clicker/src/core/model/pet_model.dart';

part 'smrcka_state.freezed.dart';

@freezed
class SmrckaState with _$SmrckaState {
  const factory SmrckaState.initial() = Initial;
  const factory SmrckaState.error() = Error;
  const factory SmrckaState.loaded(PetModel smrcka) = Loaded;
  const factory SmrckaState.pet(PetModel smrcka) = Pet;
  const factory SmrckaState.troll(PetModel smrcka) = Troll;
}
