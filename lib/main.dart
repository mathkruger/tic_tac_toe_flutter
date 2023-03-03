import 'package:flutter/material.dart';
import 'package:tic_tac_toe_flutter/src/view/game_view.dart';
import 'package:tic_tac_toe_flutter/src/view/main_view.dart';

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tic Tac Toe',
      theme: ThemeData(
        primarySwatch: Colors.amber,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const MainView(title: 'Home'),
        '/game': (context) => GameView(title: 'Game'),
      },
    );
  }
}
