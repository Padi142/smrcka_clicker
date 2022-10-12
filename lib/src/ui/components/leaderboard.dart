import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smrcka_clicker/src/core/bloc/leaderboard/leaderboard_bloc.dart';
import 'package:smrcka_clicker/src/core/bloc/leaderboard/leaderboard_state.dart';
import 'package:smrcka_clicker/src/core/model/pet_model.dart';
import 'package:smrcka_clicker/src/ui/components/loading.dart';
import 'package:smrcka_clicker/src/ui/components/nick_changer.dart';
import 'package:smrcka_clicker/src/core/bloc/leaderboard/leaderboard_bloc.dart';

class Leaderboard extends StatefulWidget {
  final PetModel pet;
  const Leaderboard({required this.pet, super.key});

  @override
  State<Leaderboard> createState() => _LeaderboardState();
}

class _LeaderboardState extends State<Leaderboard> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<LeaderboardBloc>(context).add(const LoadEvent());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LeaderboardBloc, LeaderboardState>(
      builder: ((context, state) {
        return state.maybeWhen(loaded: ((username, sortedBoard, myPosition) {
          return SizedBox(
            width: 300,
            child: Column(
              children: [
                ListTile(
                  leading: const Text(
                    "Pořadí:",
                    style: TextStyle(color: Colors.white),
                  ),
                  title: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: const [
                        Text("Nick:", style: TextStyle(color: Colors.white)),
                        Text("Šotkování:",
                            style: TextStyle(color: Colors.white))
                      ]),
                  trailing: const Text("Clicks:",
                      style: TextStyle(color: Colors.white)),
                ),
                ListView.builder(
                    shrinkWrap: true,
                    itemCount: sortedBoard.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        tileColor: Colors.purpleAccent,
                        leading: Text(
                          "${index + 1}.",
                          style: const TextStyle(
                              fontSize: 26, fontWeight: FontWeight.bold),
                        ),
                        title: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              sortedBoard[index].username,
                              style: const TextStyle(fontSize: 26),
                            ),
                            const SizedBox(
                              width: 40,
                            ),
                            Text(
                              sortedBoard[index].sotekCount.toString(),
                              style: const TextStyle(fontSize: 20),
                            ),
                          ],
                        ),
                        trailing: Text(
                          sortedBoard[index].clicks.toString(),
                          style: const TextStyle(fontSize: 20),
                        ),
                      );
                    }),
                const SizedBox(
                  height: 10,
                ),
                NickChanger(
                  currentNick: username,
                )
              ],
            ),
          );
        }), orElse: (() {
          return const Loading();
        }));
      }),
    );
  }
}
