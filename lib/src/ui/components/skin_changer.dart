import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smrcka_clicker/src/core/bloc/smrcka_bloc/smrcka_bloc.dart';
import 'package:smrcka_clicker/src/core/model/pet_model.dart';
import 'package:smrcka_clicker/src/ui/components/skin_button.dart';

class SkinChanger extends StatelessWidget {
  final PetModel pet;
  const SkinChanger({super.key, required this.pet});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text(
          "Skiny:",
          style: TextStyle(color: Colors.white, fontSize: 24),
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              NewSkinButton(
                pet: pet,
                petImg: "assets/images/smrckasantapat.gif",
                skinImg: "assets/images/smrckasanta.jpg",
                skinLabel: "Santa Smrčka",
              ),
              NewSkinButton(
                pet: pet,
                petImg: "assets/images/smrckasnehpat.gif",
                skinImg: "assets/images/smrckasneh.jpg",
                skinLabel: "Sněhový Smrčka",
              ),
              NewSkinButton(
                pet: pet,
                petImg: "assets/images/smrckagrinchpat.gif",
                skinImg: "assets/images/smrckagrinch.jpg",
                skinLabel: "Smrčka Grinch",
              ),
              NewSkinButton(
                pet: pet,
                petImg: "assets/images/smrckadeerpat.gif",
                skinImg: "assets/images/smrckadeer.jpg",
                skinLabel: "Sobí Smrčka",
              ),
              NewSkinButton(
                pet: pet,
                petImg: "assets/images/JakcSmrskagtonpat.gif",
                skinImg: "assets/images/JakcSmrskagton.jpg",
                skinLabel: "Jack Smrčkagton",
              ),
              NewSkinButton(
                pet: pet,
                petImg: "assets/images/Legosmrckapat.gif",
                skinImg: "assets/images/Legosmrcka.jpg",
                skinLabel: "Lego Smrčka",
              ),
              SkinButton(
                pet: pet,
                petImg: "assets/images/pat.gif",
                skinImg: "assets/images/smrcka.jpg",
                skinLabel: "Normalni Smrcka",
              ),
              SkinButton(
                pet: pet,
                petImg: "assets/images/dravensmrckapat.gif",
                skinImg: "assets/images/smrckadraven.jpg",
                skinLabel: "Draven Smrčka",
              ),
              SkinButton(
                pet: pet,
                petImg: "assets/images/egirlpat.gif",
                skinImg: "assets/images/smrckaegirl.jpg",
                skinLabel: "Egirl Smrcka",
              ),
              SkinButton(
                pet: pet,
                petImg: "assets/images/8bitsmrckapat.gif",
                skinImg: "assets/images/8bitsmrcka.jpg",
                skinLabel: "8bit Smrčka",
              ),
              SkinButton(
                pet: pet,
                petImg: "assets/images/furrypat.gif",
                skinImg: "assets/images/furrysmrk.jpg",
                skinLabel: "Furry Smrčka?!?",
              ),
              SkinButton(
                pet: pet,
                petImg: "assets/images/d.smrckapat.gif",
                skinImg: "assets/images/dvasmrcka.jpg",
                skinLabel: "D.va Smrčka",
              ),
              SkinButton(
                pet: pet,
                petImg: "assets/images/smrckamimonpat.gif",
                skinImg: "assets/images/smrckamimon.jpg",
                skinLabel: "Mimoň Smrčka",
              ),
              SkinButton(
                pet: pet,
                petImg: "assets/images/smrekpat.gif",
                skinImg: "assets/images/smrek.jpg",
                skinLabel: "Smrek",
              ),
              SkinButton(
                pet: pet,
                petImg: "assets/images/smrcka_sanchezpat.gif",
                skinImg: "assets/images/smrcka_sanchez.jpg",
                skinLabel: "Richard Smrčka",
              ),
              SkinButton(
                pet: pet,
                petImg: "assets/images/smrckasuspat.gif",
                skinImg: "assets/images/SmrcUS.jpg",
                skinLabel: "Sussy Smrčka",
              ),
              SkinButton(
                pet: pet,
                petImg: "assets/images/cloudsmrckapat.gif",
                skinImg: "assets/images/cloudsmrcka.jpg",
                skinLabel: "Cloud rapper Smrčka",
              ),
              SkinButton(
                pet: pet,
                petImg: "assets/images/berniesmrckapat.gif",
                skinImg: "assets/images/berniesmrcka.jpg",
                skinLabel: "Bernie Smrčka",
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        const Text("Skiny by: @blil_vodku",
            style: TextStyle(
              color: Colors.white,
            ))
      ],
    );
  }
}

class SkinButton extends StatelessWidget {
  final String skinLabel;
  final String skinImg;
  final String petImg;
  final PetModel pet;
  const SkinButton(
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
        child: SizedBox(
          height: 50,
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
      ),
    );
  }
}
