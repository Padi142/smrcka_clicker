part of 'smrcka_bloc.dart';

abstract class SmrckaEvent extends Equatable {
  const SmrckaEvent();

  @override
  List<Object> get props => [];
}

class InitialEvent extends SmrckaEvent {
  const InitialEvent();

  @override
  List<Object> get props => [];
}

class PetEvent extends SmrckaEvent {
  final PetModel pet;
  const PetEvent(this.pet);

  @override
  List<Object> get props => [];
}

class ChangeSkin extends SmrckaEvent {
  final PetModel pet;
  final String imgSkin;
  final String petSkin;
  const ChangeSkin(this.pet, this.imgSkin, this.petSkin);

  @override
  List<Object> get props => [];
}
