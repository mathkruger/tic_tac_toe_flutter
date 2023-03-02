import 'package:flutter/material.dart';
import 'package:tic_tac_toe_flutter/src/view/game_view.dart';

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.amber,
      ),
      home: const GameView(title: 'Tic Tac Toe'),
    );
  }
}
