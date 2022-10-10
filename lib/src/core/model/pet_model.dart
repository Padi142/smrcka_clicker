import 'package:equatable/equatable.dart';

class PetModel extends Equatable {
  final String name;
  final String image;
  final String petImage;
  final int pets;

  const PetModel(
      {required this.name,
      required this.pets,
      required this.image,
      required this.petImage});
  @override
  List<Object?> get props => [name, pets];

  PetModel copyWith(
      {String? name, String? image, String? petImage, int? pets}) {
    return PetModel(
        name: name ?? this.name,
        pets: pets ?? this.pets,
        image: image ?? this.image,
        petImage: petImage ?? this.petImage);
  }
}
