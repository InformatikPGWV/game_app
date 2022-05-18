import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Enum stellt 2 Spieler zur Verfügung
enum Player {
  player1,
  player2,
}

/// Einstellungs Bildschirm
class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  /// Name der Route
  static const routeName = "/settings";

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

/// State des Einstellungs-Bildscirms
class _SettingsScreenState extends State<SettingsScreen> {
  /// Der TextEditingController wird verwendet, um Eingaben
  /// aus dem Textfeld auszulesen und neue Eingaben anzufertigen.
  TextEditingController _serverAddressController = TextEditingController();

  /// Wert des dropdown Menüs Standardmäßig Player1 bis der eigentliche Wert
  /// vom Speicher ausgelesen wird.
  var _dropdownValue = Player.player1;

  /// Funktion um Einstellungen zu speichern.
  void _saveSettings() async {
    /// Erstelle Instanz für SharedPreferences.
    var prefs = await SharedPreferences.getInstance();

    /// Verwende die Instanz um die Server Addresse zu speichern.
    await prefs.setString("serverAddress", _serverAddressController.text);

    /// Speichere den Spieler
    if (_dropdownValue == Player.player1) {
      await prefs.setString("player", "player1");
    } else if (_dropdownValue == Player.player2) {
      await prefs.setString("player", "player2");
    }
  }

  /// Lade die gespeicherten Daten.
  void _loadSettings() async {
    /// Erstelle Instanz für SharedPreferences.
    var prefs = await SharedPreferences.getInstance();

    /// Lade die Daten des Servers.
    String? _serverAddressLocal = await prefs.getString("serverAddress");
    String? _dropdownValueLocal = await prefs.getString("player");

    /// Setze den Wert des Dropdown Menus basierend auf den geladenen Daten.
    /// Gibt es keine Daten, verwende Spieler 1.
    if (_dropdownValueLocal == "player1") {
      _dropdownValue = Player.player1;
    } else if (_dropdownValueLocal == "player2") {
      _dropdownValue = Player.player2;
    } else {
      _dropdownValue = Player.player1;
    }

    /// Setze den Wert des Textfeldes
    setState(() {
      _serverAddressController.text = _serverAddressLocal ?? "";
    });
  }

  /// Initialisierungsfunkltion, welche beim
  /// Erstellen des Widgets ausgeführt wird.
  @override
  void initState() {
    super.initState();
    _loadSettings();
  }

  /// Build-Funktion
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      /// Erstelle eine AppBar mit Titel
      appBar: AppBar(
        title: Text("Settings"),
      ),

      /// Erstelle eine Box, die die gesamte
      /// Breite des Bildschirms einnimmt.
      body: SizedBox(
        width: double.infinity,

        /// Abstand innerhalb des Widgets (zum Bildschirmrand).
        child: Padding(
          padding: const EdgeInsets.fromLTRB(5, 10, 5, 0),

          /// Zeilen Widget ordnet enthhaltene Widgets untereinander an.
          child: Column(
            /// Ausrichtung: Oben zentriert
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,

            /// Liste untergeordneter Widgets.
            children: [
              /// Textfeld zum Eingeben der Serveraddresse.
              TextField(
                controller: _serverAddressController,
                maxLines: 1,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  label: Text("server address"),
                  hintText: "ws://example.com",
                ),

                /// Führe beim Drücken von OK oder Enter die Funktion aus
                onSubmitted: (_) {
                  _saveSettings();
                },
              ),

              /// Abstand innerhalb des Widgets (zum Bildschirmrand).
              Padding(
                padding: const EdgeInsets.only(top: 20),

                /// Row Widgets stellen Widgets nebeneinander da
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "Player: ",
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 10),

                      /// Dropdown Menü
                      child: DropdownButton(
                        /// Ausgewähltes Item
                        value: _dropdownValue,

                        /// Auswahlmöglichkeiten
                        items: [
                          DropdownMenuItem(
                            child: Text("Player 1"),
                            value: Player.player1,
                          ),
                          DropdownMenuItem(
                            child: Text("Player 2"),
                            value: Player.player2,
                          ),
                        ],

                        /// Führe Funktion beim klicken auf die Auswahl aus.
                        /// Speichere im Anschluss.
                        onChanged: (Player? newValue) {
                          setState(() {
                            _dropdownValue = newValue ?? Player.player1;
                          });
                          _saveSettings();
                        },
                      ),
                    ),
                  ],
                ),
              ),

              /// Speichern-Knopf
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () => _saveSettings(),
                  child: Text("Save"),
                  style: ElevatedButton.styleFrom(
                    primary: Colors.green,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
