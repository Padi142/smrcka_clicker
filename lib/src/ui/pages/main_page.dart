import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smrcka_clicker/src/core/bloc/smrcka_bloc/smrcka_bloc.dart';
import 'package:smrcka_clicker/src/core/bloc/smrcka_bloc/smrcka_state.dart';
import 'package:smrcka_clicker/src/core/model/pet_model.dart';
import 'package:smrcka_clicker/src/ui/components/skin_changer.dart';
import 'package:url_launcher/url_launcher.dart';

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
          }, troll: (smrcka) {
            return const TrollBody();
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
          "  klikni na svého oblíbeného přednášejícího: ",
          textAlign: TextAlign.center,
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
        const SizedBox(
          height: 40,
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Align(
            alignment: Alignment.centerRight,
            child: SizedBox(
              height: 50,
              width: 50,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(primary: Colors.grey),
                onPressed: (() async {
                  await launchUrl(
                      Uri.parse("https://github.com/Padi142/smrcka_clicker"));
                }),
                child: Image.network(
                  "https://cdn-icons-png.flaticon.com/512/25/25231.png",
                ),
              ),
            ),
          ),
        )
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

class TrollBody extends StatefulWidget {
  const TrollBody({super.key});

  @override
  State<TrollBody> createState() => _TrollBodyState();
}

class _TrollBodyState extends State<TrollBody>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 14),
      upperBound: 1,
    );
    _controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Center(
          child: RotationTransition(
            turns: Tween(begin: 0.0, end: 10.0).animate(_controller),
            child: Image.asset("assets/images/smrckatf.png"),
          ),
        ),
        const SizedBox(
          height: 30,
        ),
        FadeIn(
          animate: true,
          duration: const Duration(seconds: 2),
          delay: const Duration(seconds: 2),
          child: const Text(
            "Byl jsi vyšotkován",
            style: TextStyle(
                color: Colors.white, fontSize: 29, fontWeight: FontWeight.bold),
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        FadeIn(
          animate: true,
          duration: const Duration(seconds: 2),
          delay: const Duration(seconds: 6),
          child: const Text(
            "-10 bodů :PepeLa:",
            style: TextStyle(
                color: Colors.white, fontSize: 35, fontWeight: FontWeight.bold),
          ),
        )
      ],
    );
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
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
