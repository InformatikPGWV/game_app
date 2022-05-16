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
      body: SizedBox(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text("LOL"),
          ],
        ),
      ),
    );
  }
}
