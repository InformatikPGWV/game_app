import 'package:flutter/material.dart';
import 'package:game_app/src/ws_handeling/ws_connection.dart';
import 'package:provider/provider.dart';

class PongGameScreen extends StatefulWidget {
  const PongGameScreen({Key? key}) : super(key: key);

  static const routeName = "/pong";

  @override
  State<PongGameScreen> createState() => _PongGameScreenState();
}

class _PongGameScreenState extends State<PongGameScreen> {
  late var ws = context.read<WsConnection>();

  String player = "clientP1";

  // --------------------

  void upPressed() {
    Map data = {
      "sender": player,
      "receiver": "server",
      "timestamp": DateTime.now().microsecondsSinceEpoch.toString(),
      "data": {
        "action": "upPressed",
      }
    };
  }

  void upReleased() {}

  // --------------------

  void downPressed() {}

  void downReleased() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Pong"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SizedBox(
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Flexible(
                child: SizedBox(
                  height: double.infinity,
                  width: double.infinity,
                  child: Listener(
                    onPointerDown: (details) => upPressed(),
                    onPointerUp: (details) => upReleased(),
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
              SizedBox(
                height: 8,
              ),
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