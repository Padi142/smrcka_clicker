import 'package:equatable/equatable.dart';

class PetModel extends Equatable {
  final String name;
  final String image;
  final int pets;

  const PetModel({required this.name, required this.pets, required this.image});
  @override
  List<Object?> get props => [name, pets];
}
