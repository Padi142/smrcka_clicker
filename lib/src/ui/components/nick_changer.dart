import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smrcka_clicker/src/core/bloc/leaderboard/leaderboard_bloc.dart';

class NickChanger extends StatefulWidget {
  final String? currentNick;
  const NickChanger({super.key, required this.currentNick});

  @override
  State<NickChanger> createState() => _NickChangerState();
}

class _NickChangerState extends State<NickChanger> {
  bool usernameEntered = false;
  final TextEditingController _controller = TextEditingController();
  @override
  void initState() {
    if (widget.currentNick != null) {
      _controller.text = widget.currentNick!;
      usernameEntered = true;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width: 100,
          child: TextField(
            controller: _controller,
            decoration: const InputDecoration(
                border: OutlineInputBorder(),
                filled: true,
                fillColor: Colors.white,
                labelText: "Nick:",
                labelStyle: TextStyle(color: Colors.blueAccent)),
          ),
        ),
        usernameEntered
            ? Text(
                "Nick: ${widget.currentNick ?? ""}",
                style: const TextStyle(color: Colors.white),
              )
            : ElevatedButton(
                onPressed: () async {
                  if (_controller.text != "" && _controller.text.length < 25) {
                    final prefs = await SharedPreferences.getInstance();
                    prefs.setString("username", _controller.text);
                    if (widget.currentNick != null) {
                      // ignore: use_build_context_synchronously
                      BlocProvider.of<LeaderboardBloc>(context)
                          .add(CreateScore(_controller.text, 0));
                    }
                    setState(() {
                      usernameEntered = true;
                    });
                  }
                },
                child: const Text("Uložit"))
      ],
    );
  }
}
