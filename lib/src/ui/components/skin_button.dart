import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smrcka_clicker/src/core/bloc/smrcka_bloc/smrcka_bloc.dart';
import 'package:smrcka_clicker/src/core/model/pet_model.dart';

class NewSkinButton extends StatelessWidget {
  final String skinLabel;
  final String skinImg;
  final String petImg;
  final PetModel pet;
  const NewSkinButton(
      {super.key,
      required this.skinLabel,
      required this.skinImg,
      required this.petImg,
      required this.pet});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4),
      child: GestureDetector(
        onTap: () {
          BlocProvider.of<SmrckaBloc>(context)
              .add(ChangeSkin(pet, skinImg, petImg));
        },
        child: Column(
          children: [
            const Text(
              "Nové!",
              style: TextStyle(color: Colors.red),
            ),
            SizedBox(
              height: 40,
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.purpleAccent),
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.all(8),
                    child: Text(
                      skinLabel,
                      style: const TextStyle(
                          fontSize: 22, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
