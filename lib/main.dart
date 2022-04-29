import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';

import 'src/home_screen.dart';

void main() {
  runApp(const MyApp());
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
      },
      initialRoute: HomePage.routeName,
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);
  static const routeName = "/";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Game Companion Alpha"),
        centerTitle: false,
      ),
      body: HomeScreen(),
    );
  }
}
