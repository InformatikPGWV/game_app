import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:game_app/src/ws_handeling/ws_connection.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Pong Screen (Diesesmal Stateful)
/// Stateful = Inhalte auf dem Bildschirm können sich Verändern
class PongGameScreen extends StatefulWidget {
  const PongGameScreen({Key? key}) : super(key: key);

  static const routeName = "/pong";

  @override
  State<PongGameScreen> createState() => _PongGameScreenState();
}

/// Pong Screen State
class _PongGameScreenState extends State<PongGameScreen> {
  /// Lese die WsConnection vom Provider aus der main.dart
  /// datei aus, um sie hier verwenden zu können
  late var ws = context.read<WsConnection>();

  /// Erstelle einen String namens Player.
  /// Dieser hat vorerst keinen wert. Er
  /// wird später (--> late) zugewiesen.
  late String player;

  /// Führe folgende Funktionen beim Initialisieren
  /// dar. (Initialisieren = erstes darstellen)
  @override
  void initState() {
    super.initState();
    getPlayerFromMemory();
    ws.setAddressFromMemory();
    ws.connectAndListen();
  }

  /// Lade den gespeicherten Spieler aus dem Speicher
  void getPlayerFromMemory() async {
    /// Erstelle Instanz von Shared Preferences.
    var instance = await SharedPreferences.getInstance();

    /// Verwende die Instanz und lade die Daten mit dem
    /// Key "Player". Key und Value sind ähnlich oder gleich
    /// wie Python Dictionaries. Hier heißen sie Map.
    var loadedPlayer = await instance.getString("player");

    /// Handelt es sich um Spieler 1 oder 2 speichere die geladenen
    /// Daten in der Player Variable
    if (loadedPlayer == "player1" || loadedPlayer == "player2") {
      player = loadedPlayer!;
    }

    /// Liegt kein Wert, oder ein falscher Wert vor, verwende
    /// Spieler 1
    else {
      player = "player1";
    }
  }

  // --------------------

  /// Funktion die beim herunterdrücken des Hoch-Buttons ausgeführt wird.
  void upPressed() {
    /// Erstelle eine Map mit den zu versendenden Daten
    Map data = {
      "sender": player,
      "receiver": "server",
      "game": "pong",
      "timestamp": DateTime.now().millisecondsSinceEpoch.toString(),
      "data": {
        "action": "upPressed",
      }
    };

    /// Kodiere die Daten ins Json-Format und
    /// sende die Daten an den Server
    ws.sendData(jsonEncode(data));
  }

  /// Funktion die beim loslassen des Hoch-Buttons ausgeführt wird.
  /// Details: Siehe Beshreibung von upPressed
  void upReleased() {
    Map data = {
      "sender": player,
      "receiver": "server",
      "game": "pong",
      "timestamp": DateTime.now().millisecondsSinceEpoch.toString(),
      "data": {
        "action": "upReleased",
      }
    };

    ws.sendData(jsonEncode(data));
  }

  // --------------------

  /// Funktion die beim herunterdrücken des runter-Buttons ausgeführt wird.
  /// Details: Siehe Beshreibung von upPressed
  void downPressed() {
    Map data = {
      "sender": player,
      "receiver": "server",
      "game": "pong",
      "timestamp": DateTime.now().millisecondsSinceEpoch.toString(),
      "data": {
        "action": "downPressed",
      }
    };

    ws.sendData(jsonEncode(data));
  }

  /// Funktion die beim loslassen des Runter-Buttons ausgeführt wird.
  /// Details: Siehe Beshreibung von upPressed
  void downReleased() {
    Map data = {
      "sender": player,
      "receiver": "server",
      "game": "pong",
      "timestamp": DateTime.now().millisecondsSinceEpoch.toString(),
      "data": {
        "action": "downReleased",
      }
    };

    ws.sendData(jsonEncode(data));
  }

  /// Build Methode des Widgets (Grafische Darstellung)
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      /// Erstelle eine App-Bar mit dem Titel
      /// "Pong"
      appBar: AppBar(
        title: Text("Pong"),
      ),

      /// Erstelle ein Abstands-Widget mit dem Abstand von
      /// 8px auf allen Seiten
      body: Padding(
        padding: const EdgeInsets.all(8.0),

        /// Erstelle die Breiteste mögliche Box
        child: SizedBox(
          width: double.infinity,

          /// Zeilen Widget (mehrere Widgets werden untereinander dargestellt)
          child: Column(
            /// Richte die untergeordneten Widgets Zentriert von oben aus aus.
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              /// Flexible teilt sich den Platz gerecht (wenn nicht anders
              /// angegeben) mit den anderen Flex-Widgets in der Zeile ein.
              Flexible(
                /// Box, die größtmöglichen Plazu einnimmt
                child: SizedBox(
                  height: double.infinity,
                  width: double.infinity,

                  /// Listener kann auf Interaktionen reagieren.
                  /// In diesem fall, führt er eine Funktion aus, wenn man
                  /// den Knopf herunterdrückt und eine andere Funktion,
                  /// wenn man den knopf loslässt.
                  child: Listener(
                    onPointerDown: (details) => upPressed(),
                    onPointerUp: (details) => upReleased(),

                    /// Button wird nur für das Layout verwendet. Er führt keine Funktion aus.
                    child: ElevatedButton(
                      onPressed: () {},
                      child: Icon(
                        Icons.arrow_upward,
                        size: 100,
                      ),
                    ),
                  ),
                ),
              ),

              /// Abstand zum anderen Button
              SizedBox(
                height: 8,
              ),

              /// Beschreibung s.o.
              Flexible(
                child: SizedBox(
                  height: double.infinity,
                  width: double.infinity,
                  child: Listener(
                    onPointerDown: (details) => downPressed(),
                    onPointerUp: (details) => downReleased(),
                    child: ElevatedButton(
                      onPressed: () {},
                      child: Icon(
                        Icons.arrow_downward,
                        size: 100,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
