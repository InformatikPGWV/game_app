import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);
  static const routeName = "/settings";

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  TextEditingController _serverAddressController = TextEditingController();

  void _saveSettings() async {
    var prefs = await SharedPreferences.getInstance();
    await prefs.setString("serverAddress", _serverAddressController.text);
  }

  void _loadSettings() async {
    var prefs = await SharedPreferences.getInstance();
    var _serverAddress = await prefs.getString("serverAddress") ?? "";
    setState(() {
      _serverAddressController.text = _serverAddress;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
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
