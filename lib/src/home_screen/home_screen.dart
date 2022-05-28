import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:game_app/src/debug_screen/debug_screen.dart';
import 'package:game_app/src/pong_game_screen/pong_game_screen.dart';
import 'package:game_app/src/settings_screen/settings_screen.dart';
import 'package:google_fonts/google_fonts.dart';

/// Erstelle die HomeScreen Klasse. Ein objekt der Klasse wird beim
/// Aufrufen erstellt.
class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  /// Name der Route / des Bildschirms
  static const routeName = "/";

  @override
  Widget build(BuildContext context) {
    /// Das Scaffold Widget stellt benötigte UI-Elemente
    /// wie die App-Bar zur Verfügung. Texte erhalten durch dieses
    /// Widget ein Standard-Design.
    return Scaffold(
      /// Oberer Teil des Bildschirms mit Titel und Knöpfen auf der rechten Seite
      appBar: AppBar(
        /// dargestellter Titel
        title: Text("Game Companion Alpha"),
        centerTitle: false,

        /// Knöpfe auf der rechten Seite
        actions: [
          /// Klickbares Icon
          IconButton(
            /// Beim Drücken des Knopfes:
            onPressed: () {
              /// Öffne den Einstellungs-Bildschirm
              Navigator.of(context).pushNamed(SettingsScreen.routeName);
            },

            /// Icon, welches dargestellt werden soll
            icon: Icon(Icons.settings),
          ),

          /// Beschreibung wie oben nur mit den Entwickler
          /// Optionen an Stelle der Einstellungen
          IconButton(
            onPressed: () {
              Navigator.of(context).pushNamed(DebugScreen.routeName);
            },
            icon: Icon(Icons.developer_mode),
          ),
        ],
      ),

      /// Hauptteil der App (Alles unter der AppBar)
      body: Container(
        /// Stelle die Breite und höhe auf den größtmöglischen wert,
        /// der auf den Bildschirm passt
        width: double.infinity,
        height: double.infinity,

        /// Ausrichtung der Untergeordneten Widgets: Zentriert Oben
        alignment: Alignment.topCenter,

        /// Zeilen Widget (mehrere Widgets werden untereinander dargestellt)
        child: Column(
          /// Richte die untergeordneten Widgets Zentriert von oben aus aus.
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            /// Abstand nach Oben
            SizedBox(
              height: 20,
            ),

            /// Großer Text / Titel (Die Textgröße wird an den Bildschirm angepasst)
            AutoSizeText(
              "Spiel auswählen",
              maxLines: 1,

              /// Lade die Schrifrart amaticSc von Google Fonts herunter und verwende sie
              style: GoogleFonts.amaticSc().copyWith(
                /// Schriftgröße 90, Fett
                fontSize: 90,
                fontWeight: FontWeight.bold,
              ),
            ),

            /// Abstand
            SizedBox(
              height: 20,
            ),

            // /// Lücke von 8px um das gesamte untergeordnete Objekt
            // Padding(
            //   padding: const EdgeInsets.all(8.0),

            //   /// Die Sized Box streckt die breite des Knopfes auf 400px
            //   child: SizedBox(
            //     width: 400,

            //     /// Knopf mit hintergrund und Schatten
            //     child: ElevatedButton(
            //       /// Beim drücken:
            //       onPressed: () {
            //         /// pffne den Tic-Tac-Toe Bildschirm
            //         Navigator.of(context).pushNamed(TttGameScreen.routeName);
            //       },

            //       /// Dargestellter Text im Knopf
            //       child: Text("Tic-Tac-Toe"),
            //       style: ElevatedButton.styleFrom(
            //         primary: Colors.green,
            //       ),
            //     ),
            //   ),
            // ),

            /// Gleiche Beschreibung wie beim Widget darüber
            /// Außer: Jetzt wird der Pong-Screen Verwendet
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                width: 400,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pushNamed(PongGameScreen.routeName);
                  },
                  child: Text("Pong"),
                  style: ElevatedButton.styleFrom(
                    primary: Colors.teal,
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
