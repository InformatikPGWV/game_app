import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'src/ws_handeling/ws_connection.dart';
import 'src/home_screen/home_screen.dart';
import 'src/ttt_game_screen/ttt_game_screen.dart';
import 'src/debug_screen/debug_screen.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        Provider<WsConnection>(
          create: (_) => WsConnection("ws://localhost:8080"),
        ),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Game Companion Alpha',
      theme: ThemeData(
        colorScheme: ColorScheme.light().copyWith(
          primary: Colors.blue,
          secondary: Colors.blueAccent,
        ),
      ),
      darkTheme: ThemeData(
        colorScheme: ColorScheme.dark().copyWith(
          primary: Colors.blue,
          secondary: Colors.blueAccent,
        ),
      ),
      themeMode: ThemeMode.system,
      routes: {
        HomePage.routeName: (context) => HomePage(),
        TttGameScreen.routeName: (context) => TttGameScreen(),
        DebugScreen.routeName: (context) => DebugScreen(),
      },
      initialRoute: HomePage.routeName,
    );
  }
}
