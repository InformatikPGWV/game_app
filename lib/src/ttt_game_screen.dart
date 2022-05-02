import 'package:flutter/material.dart';

class TttGameScreen extends StatefulWidget {
  TttGameScreen({Key? key}) : super(key: key);

  @override
  State<TttGameScreen> createState() => _TttGameScreenState();
}

class _TttGameScreenState extends State<TttGameScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
        width: double.infinity,
        height: double.infinity,
        child: Container(
        alignment: Alignment.center,
        child: Stack(
            children:[
                TttGridOverlay(),
            ],
        ),
        ),
    );
  }
}

class TttGridOverlay extends StatefulWidget {
  TttGridOverlay({Key? key}) : super(key: key);

  @override
  State<TttGridOverlay> createState() => _TttGridOverlayState();
}

class _TttGridOverlayState extends State<TttGridOverlay> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}