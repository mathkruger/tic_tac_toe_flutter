import 'package:flutter/material.dart';
import 'package:tic_tac_toe_flutter/src/controller/game_controller.dart';

import '../model/game_model.dart';

class GameView extends StatefulWidget {
  final String title;

  const GameView({Key? key, required this.title}) : super(key: key);

  @override
  State<GameView> createState() => _MainPageState();
}

class _MainPageState extends State<GameView> {
  GameController controller = GameController();

  final circle = const Image(image: AssetImage('images/circle.png'));
  final cross = const Image(image: AssetImage('images/cross.png'));

  void _matchEnded(String winner) {
    setState(() {
      controller.clearBoard();
      controller.updateScore(winner);
    });
  }

  Widget _buildPointsTable() {
    const textStyle = TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0);

    return Expanded(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                SizedBox(width: 64, height: 64, child: circle),
                const SizedBox(height: 5),
                Text(controller.getScoreOString(), style: textStyle)
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                SizedBox(width: 64, height: 64, child: cross),
                const SizedBox(height: 5),
                Text(controller.getScoreXString(), style: textStyle)
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _buildGrid() {
    final elements = {'x': cross, 'o': circle, '': null};
    return Expanded(
        flex: 3,
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: GridView.builder(
            itemCount: controller.getBoardList().length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3),
            itemBuilder: (BuildContext context, int index) {
              return GestureDetector(
                  onTap: () {
                    setState(() {
                      String? winner = controller.tapped(index);

                      if (winner != null) {
                        controller.outputWinner(
                            context, winner == '' ? 'Draw' : 'Winner', winner,
                            () {
                          _matchEnded(winner);
                        });
                      }
                    });
                  },
                  child: Container(
                    padding: const EdgeInsets.all(32.0),
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey.shade700)),
                    child: elements[controller.getBoardList()[index]],
                  ));
            },
          ),
        ));
  }

  Widget _buildTurn() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text('Current turn'),
          const SizedBox(height: 10),
          controller.isOTurn()
              ? SizedBox(width: 32, height: 32, child: circle)
              : SizedBox(width: 32, height: 32, child: cross),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        actions: [
          IconButton(
              icon: const Icon(Icons.refresh),
              onPressed: () {
                setState(() {
                  controller.clearBoard(clearGame: true);
                });
              }),
        ],
        title: Text(widget.title),
      ),
      body: Container(
          color: Theme.of(context).colorScheme.background,
          child: Column(
            children: [_buildPointsTable(), _buildGrid(), _buildTurn()],
          )),
    );
  }
}
