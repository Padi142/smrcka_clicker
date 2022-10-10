import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smrcka_clicker/src/core/bloc/smrcka_bloc/smrcka_bloc.dart';
import 'package:smrcka_clicker/src/core/bloc/smrcka_bloc/smrcka_state.dart';
import 'package:smrcka_clicker/src/core/model/pet_model.dart';
import 'package:smrcka_clicker/src/ui/components/skin_changer.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<SmrckaBloc>(context).add(const InitialEvent());
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(
      body: SingleChildScrollView(child: BlocBuilder<SmrckaBloc, SmrckaState>(
        builder: ((context, state) {
          return state.maybeWhen(loaded: ((smrcka) {
            return PetShowPage(pet: smrcka);
          }), pet: (pet) {
            return PetPage(
              pet: pet,
            );
          }, orElse: (() {
            return const Loading();
          }));
        }),
      )),
    ));
  }
}

class PetShowPage extends StatelessWidget {
  final PetModel pet;
  const PetShowPage({required this.pet, super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: 20,
        ),
        const Text(
          "klikni na svého oblíbeného přednášejícího: ",
          style: TextStyle(fontSize: 28, color: Colors.white),
        ),
        const SizedBox(
          height: 6,
        ),
        Text(
          pet.pets.toString(),
          style: const TextStyle(
              fontWeight: FontWeight.bold, fontSize: 25, color: Colors.white),
        ),
        Center(
          child: GestureDetector(
              onTap: () {
                BlocProvider.of<SmrckaBloc>(context).add(PetEvent(pet));
              },
              child: Image.asset(
                pet.image,
                height: 350,
                width: 250,
              )),
        ),
        const SizedBox(
          height: 40,
        ),
        SkinChanger(pet: pet),
      ],
    );
  }
}

class PetPage extends StatelessWidget {
  final PetModel pet;
  const PetPage({required this.pet, super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Center(
          child: Image.asset(
            pet.petImage,
            height: 350,
            width: 250,
            scale: 0.6,
          ),
        ),
      ],
    );
  }
}

class Loading extends StatelessWidget {
  const Loading({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }
}
