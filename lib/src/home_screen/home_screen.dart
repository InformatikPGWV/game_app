import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:game_app/src/debug_screen/debug_screen.dart';
import 'package:google_fonts/google_fonts.dart';

import '../ttt_game_screen/ttt_game_screen.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);
  static const routeName = "/";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Game Companion Alpha"),
        centerTitle: false,
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        alignment: Alignment.topCenter,
        child: ConstrainedBox(
          constraints: BoxConstraints(
            minWidth: 500,
            maxWidth: 800,
          ),
          child: Container(
            color: Color.fromARGB(21, 255, 0, 230),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Margin
                SizedBox(
                  height: 20,
                ),
                // Title
                AutoSizeText(
                  "Spiel auswählen",
                  maxLines: 1,
                  style: GoogleFonts.amaticSc().copyWith(
                    fontSize: 90,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                // Margin
                SizedBox(
                  height: 20,
                ),
                // TTT Button
                SizedBox(
                  width: 400,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pushNamed(TttGameScreen.routeName);
                    },
                    child: Text("Tic-Tac-Toe"),
                    style: ElevatedButton.styleFrom(
                      primary: Colors.green,
                    ),
                  ),
                ),
                SizedBox(
                  width: 400,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pushNamed(DebugScreen.routeName);
                    },
                    child: Text("DEBUG"),
                    style: ElevatedButton.styleFrom(
                      primary: Colors.red,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
