import 'package:flutter/material.dart';
import 'package:game_app/main.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum Player {
  player1,
  player2,
}

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);
  static const routeName = "/settings";

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  TextEditingController _serverAddressController = TextEditingController();
  var _dropdownValue = Player.player1;

  void _saveSettings() async {
    var prefs = await SharedPreferences.getInstance();
    await prefs.setString("serverAddress", _serverAddressController.text);

    if (_dropdownValue == Player.player1) {
      await prefs.setString("player", "player1");
    } else if (_dropdownValue == Player.player2) {
      await prefs.setString("player", "player2");
    }
  }

  void _loadSettings() async {
    var prefs = await SharedPreferences.getInstance();
    var _serverAddressLocal = await prefs.getString("serverAddress") ?? "";
    var _dropdownValueLocal = await prefs.getString("player") ?? "";

    if (_dropdownValueLocal == "player1") {
      _dropdownValue = Player.player1;
    } else if (_dropdownValueLocal == "player2") {
      _dropdownValue = Player.player2;
    } else {
      _dropdownValue = Player.player1;
    }

    setState(() {
      _serverAddressController.text = _serverAddressLocal;
    });
  }

  @override
  void initState() {
    super.initState();
    _loadSettings();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Settings"),
      ),
      body: SizedBox(
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(5, 10, 5, 0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              TextField(
                controller: _serverAddressController,
                minLines: 1,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  label: Text("server address"),
                  hintText: "ws://example.com",
                ),
                onSubmitted: (_) {
                  _saveSettings();
                },
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "Player: ",
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 10),
                      child: DropdownButton(
                        value: _dropdownValue,
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
