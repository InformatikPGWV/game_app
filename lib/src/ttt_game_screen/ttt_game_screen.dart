import 'package:flutter/material.dart';

class TttGameScreen extends StatefulWidget {
  TttGameScreen({Key? key}) : super(key: key);

  static const routeName = "/ttt";

  @override
  State<TttGameScreen> createState() => _TttGameScreenState();
}

class _TttGameScreenState extends State<TttGameScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Tic-Tac-Toe"),
      ),
      body: Center(
        child: Container(
          width: 200,
          height: 200,
          alignment: Alignment.center,
          child: Stack(
            // fit: StackFit.loose,
            children: [
              Image(
                image: AssetImage(
                  "images/tTTGrid.png",
                ),
                fit: BoxFit.fill,
              ),
              TttGridOverlay(),
            ],
          ),
        ),
      ),
    );
  }
}

class TttGridOverlay extends StatefulWidget {
  const TttGridOverlay({Key? key}) : super(key: key);

  @override
  State<TttGridOverlay> createState() => _TttGridOverlayState();
}

class _TttGridOverlayState extends State<TttGridOverlay> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        // fit: StackFit.expand,
        children: [
          Text(
            "LOL",
            style: TextStyle(color: Colors.red),
          ),
        ],
      ),
    );
  }
}
