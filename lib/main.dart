import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:game_app/src/ws_handeling/ws_connection.dart';
import 'package:game_app/src/home_screen/home_screen.dart';
import 'package:game_app/src/ttt_game_screen/ttt_game_screen.dart';
import 'package:game_app/src/debug_screen/debug_screen.dart';
import 'package:game_app/src/settings_screen/settings_screen.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        Provider<WsConnection>(
          create: (_) => WsConnection("ws://s1.astrago.de:6969"), //Official Server
          // create: (_) => WsConnection("ws://[::1]:6969"), //Localhost
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
      debugShowCheckedModeBanner: false,
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
        SettingsScreen.routeName: (context) => SettingsScreen(),
      },
      initialRoute: HomePage.routeName,
    );
  }
}
