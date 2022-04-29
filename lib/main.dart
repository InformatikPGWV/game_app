import 'package:flutter/material.dart';

import 'src/home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Game Companion Alpha',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSwatch().copyWith(
          primary: Colors.blue,
          secondary: Colors.blueAccent,
        ),
      ),
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
