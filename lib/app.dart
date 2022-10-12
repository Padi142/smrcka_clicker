import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smrcka_clicker/src/core/bloc/leaderboard/leaderboard_bloc.dart';
import 'package:smrcka_clicker/src/core/bloc/smrcka_bloc/smrcka_bloc.dart';

import 'package:smrcka_clicker/constants.dart' as constants;
import 'package:smrcka_clicker/src/ui/pages/main_page.dart';

class SmrckaClickerApp extends StatelessWidget {
  const SmrckaClickerApp({
    Key? key,
  }) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider<SmrckaBloc>(
            create: (BuildContext context) => SmrckaBloc(),
          ),
          BlocProvider<LeaderboardBloc>(
            create: (BuildContext context) => LeaderboardBloc(),
          ),
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: "Smrcka Clicker",
          theme: ThemeData(
            scaffoldBackgroundColor: constants.backroudColor,
            canvasColor: constants.mainColor,
            textTheme: GoogleFonts.mirzaTextTheme(),
          ),
          home: const MainPage(),
        ));
  }
}
