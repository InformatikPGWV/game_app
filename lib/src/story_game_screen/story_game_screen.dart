import 'package:flutter/material.dart';

class StoryGameScreen extends StatelessWidget {
  const StoryGameScreen({Key? key}) : super(key: key);

  static const routeName = "/story";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Story Game"),
      ),
    );
  }
}
