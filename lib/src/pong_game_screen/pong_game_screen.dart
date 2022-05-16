import 'package:flutter/material.dart';

class PongGameScreen extends StatefulWidget {
  const PongGameScreen({Key? key}) : super(key: key);

  static const routeName = "/pong";

  @override
  State<PongGameScreen> createState() => _PongGameScreenState();
}

class _PongGameScreenState extends State<PongGameScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Pong LOL"),
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
                    onPointerDown: (details) => print("Up Down"),
                    onPointerUp: (details) => print("Up Up"),
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
                    onPointerDown: (details) => print("Down Down"),
                    onPointerUp: (details) => print("Down Up"),
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
