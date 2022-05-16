import 'package:flutter/material.dart';
import 'package:game_app/src/ws_handeling/ws_connection.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'dart:convert';

class DebugScreen extends StatefulWidget {
  DebugScreen({Key? key}) : super(key: key);

  static const routeName = "/debug";

  @override
  State<DebugScreen> createState() => _DebugScreenState();
}

class _DebugScreenState extends State<DebugScreen> {
  late var ws = context.read<WsConnection>();
  bool connected = false;
  late var stream;

  void listenAndRepeatIMeanDecode() async {
    if (!connected) {
      ws.connectAndListen();
      await Future.delayed(Duration(seconds: 1));
      stream = ws.stream.listen((event) {
        print(jsonDecode(event).runtimeType);
        // print("Fettsack");
      });
    } else {
      print("Already Connected");
    }
  }

  @override
  void initState() {
    super.initState();
    listenAndRepeatIMeanDecode();
  }

  @override
  void dispose() {
    super.dispose();
    stream.cancel();
    ws.disconnect();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Debug & Network"),
      ),
      body: Container(
        alignment: Alignment.topCenter,
        child: ConstrainedBox(
          constraints: BoxConstraints(minWidth: () {
            var _width = MediaQuery.of(context).size.width;
            if (_width > 800) {
              return 800.0;
            } else {
              return _width - 40.0;
            }
          }()),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // NETWORK
              Padding(
                padding: const EdgeInsets.only(bottom: 12.0),
                child: Text(
                  "Network",
                  style: GoogleFonts.sourceCodePro().copyWith(
                    fontSize: 30,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
              Builder(builder: (context) {
                if (ws.isConnected) {
                  return StreamBuilder(
                    stream: ws.stream,
                    builder: (ctx, snapshot) {
                      return AutoSizeText(
                        snapshot.data.toString(),
                      );
                    },
                  );
                } else {
                  return Text("Not Connected");
                }
              }),
              TextButton(
                onPressed: () async {
                  await ws.setAddressFromMemory();
                  setState(() {
                    print("Listening on: " + ws.getAddress());
                  });
                  ws.connectAndListen();
                },
                child: Text("Connect"),
              ),
              TextButton(
                onPressed: () {
                  ws.sendData(DateTime.now().toString());
                },
                child: Text("Send"),
              ),
              TextButton(
                onPressed: () {
                  ws.disconnect();
                },
                child: Text("Disconnect"),
              ),
              TextButton(
                onPressed: () {
                  print(ws.isConnected);
                },
                child: Text("Check"),
              ),

              // BEGIN OF NEW SECTION
              Divider(
                color: Colors.red,
                height: 10,
              ),

              // JSON

              Padding(
                padding: const EdgeInsets.only(bottom: 12.0),
                child: Text(
                  "JSON",
                  style: GoogleFonts.sourceCodePro().copyWith(
                    fontSize: 30,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),

              // Defaut Display
              Builder(builder: (context) {
                if (ws.isConnected) {
                  return StreamBuilder(
                    stream: ws.stream,
                    builder: (ctx, snapshot) {
                      return AutoSizeText(
                        snapshot.data.toString(),
                      );
                    },
                  );
                } else {
                  return Text("Not Connected");
                }
              }),

              ElevatedButton(
                onPressed: () async {
                  Map dummy = {
                    "sender": "clientP1",
                    "receiver": "server",
                    "Timestamp": DateTime.now().millisecondsSinceEpoch,
                    "data": {
                      "lorem": "ipsum",
                      "dolor": ["sit", "amet"],
                    },
                  };

                  String json = jsonEncode(dummy);

                  ws.setAddressFromMemory();
                  ws.connectAndListen();
                  // await Future.delayed(Duration(seconds: 1));
                  //Warum?????? Eigentlich sollte es ohne gehn.
                  // Setstate is behindat LOL :/
                  // setState(() {
                  ws.sendData(json);
                  // });
                },
                child: Text("Send Json"),
              ),

              // Decoded Json LOL
            ],
          ),
        ),
      ),
    );
  }
}
