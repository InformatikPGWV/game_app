import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:game_app/src/debug_screen/debug_screen.dart';
import 'package:game_app/src/settings_screen/settings_screen.dart';
import 'package:game_app/src/story_game_screen/story_game_screen.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:game_app/src/ttt_game_screen/ttt_game_screen.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);
  static const routeName = "/";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Game Companion Alpha"),
        centerTitle: false,
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).pushNamed(SettingsScreen.routeName);
            },
            icon: Icon(Icons.settings),
          ),
          IconButton(
            onPressed: () {
              Navigator.of(context).pushNamed(DebugScreen.routeName);
            },
            icon: Icon(Icons.developer_mode),
          ),
        ],
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        alignment: Alignment.topCenter,
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
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
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
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                width: 400,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pushNamed(StoryGameScreen.routeName);
                  },
                  child: Text("Story"),
                  style: ElevatedButton.styleFrom(
                    primary: Colors.purple,
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
