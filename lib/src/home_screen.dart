import 'package:flutter/material.dart';
import 'package:game_app/src/ws_handeling/ws_connection.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var ws = WsConnection();

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Column(
          children: [
            Builder(builder: (context) {
              if (ws.isConnected) {
                return StreamBuilder(
                  stream: ws.channel.stream,
                  builder: (ctx, snapshot) {
                    return Text(snapshot.data.toString());
                  },
                );
              } else {
                return Text("Not Connected");
              }
            }),
            TextButton(
              onPressed: () {
                setState(() {
                  ws.connect();
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
    );
  }
}
