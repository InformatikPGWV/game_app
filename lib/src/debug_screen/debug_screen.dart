import 'package:flutter/material.dart';
import 'package:game_app/src/ws_handeling/ws_connection.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:auto_size_text/auto_size_text.dart';

class DebugScreen extends StatefulWidget {
  DebugScreen({Key? key}) : super(key: key);

  static const routeName = "/debug";

  @override
  State<DebugScreen> createState() => _DebugScreenState();
}

class _DebugScreenState extends State<DebugScreen> {
  late var ws = context.read<WsConnection>();

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
                  style: GoogleFonts.lexendDeca().copyWith(
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
                onPressed: () {
                  setState(() {
                    ws.connectAndListen();
                  });
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
            ],
          ),
        ),
      ),
    );
  }
}
