import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:game_app/src/ws_handeling/ws_connection.dart';
import 'package:game_app/src/home_screen/home_screen.dart';
import 'package:game_app/src/ttt_game_screen/ttt_game_screen.dart';
import 'package:game_app/src/debug_screen/debug_screen.dart';
import 'package:game_app/src/settings_screen/settings_screen.dart';
import 'package:game_app/src/pong_game_screen/pong_game_screen.dart';

void main() {
  /// Starte die App
  runApp(
    /// Verwende Provider um eine Inszanz der Objekte (Hier die WebSockets-Verbingung)
    /// für alle darunter liegenden Objekte zur Verfügung zu stellen
    MultiProvider(
      providers: [
        Provider<WsConnection>(
          /// Initialisiere WebSockets Objekt
          create: (_) => WsConnection("ws://ws.astrago.de:6969"), //Official Server
          // create: (_) => WsConnection("ws://[::1]:6969"), //Localhost
        ),
      ],

      /// Erstelle eine Instanz der MyApp Klasse und verwende sie als
      /// untergeordnetes Objekt
      child: MyApp(),
    ),
  );
}

/// Erstelle das App Widget
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  /// Erstelle bei der Build-Funktion den folgenden
  /// Widget tree (Win Widget Tree ist, ähnlich wie
  /// bei der Huffman Kodierung eine Struktur mit
  /// untergeordneten Widgets)
  @override
  Widget build(BuildContext context) {
    /// Die MaterialApp stellt die wichtigsten Features wie
    /// Routing zur verfügung. Routing ist die Navigation
    /// zwischen verschiedenen Bildschirmen (z.B. HomeScreen
    /// und der Bildschirm mit den Steuerungselementen)
    return MaterialApp(
      /// Der Titel wird in der Tab-Leiste dargestellt
      title: 'Game Companion Alpha',

      /// Der "Debug" Banner, der normalerweise beim Debuggen
      /// angezeigt wird, wird ausgeblendet.
      debugShowCheckedModeBanner: false,

      /// Die Themes stellen ein Grund-Design zur Verfügung
      /// Hier können Farben angepasst werden
      theme: ThemeData(
        colorScheme: ColorScheme.light().copyWith(
          primary: Color(0xFF284E6D),
          secondary: Colors.blueAccent,
        ),
      ),
      darkTheme: ThemeData(
        colorScheme: ColorScheme.dark().copyWith(
          primary: Color(0xFF284E6D),
          secondary: Colors.blueAccent,
        ),
      ),
      themeMode: ThemeMode.system,

      /// Routs stellen die Einzelnen Bildschirme der App
      /// dar. Sie haben einen Namen, mit dem sie aufgerufen
      /// werden können. Man sieht diesen nach dem # in der
      /// URL-Leiste des Browsers.
      routes: {
        HomeScreen.routeName: (context) => HomeScreen(),
        TttGameScreen.routeName: (context) => TttGameScreen(),
        DebugScreen.routeName: (context) => DebugScreen(),
        SettingsScreen.routeName: (context) => SettingsScreen(),
        PongGameScreen.routeName: (context) => PongGameScreen(),
      },

      /// Die Standard Route, die beim Aufrufen der Website geöffnet werden soll.
      initialRoute: HomeScreen.routeName,
    );
  }
}
