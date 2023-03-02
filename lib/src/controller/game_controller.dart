import 'package:flutter/widgets.dart';
import '../common/alert_dialog.dart';
import '../model/game_model.dart';

class GameController {
  BuildContext context;

  GameController(this.context);

  void clearBoard({bool clearGame = false}) {
    for (int i = 0; i < GameModel.xOrOList.length; i++) {
      GameModel.xOrOList[i] = '';
    }

    GameModel.filledBoxes = 0;
    GameModel.turnOfO = true;

    if (clearGame) {
      GameModel.scoreO = 0;
      GameModel.scoreX = 0;
    }
  }

  String? tapped(int index) {
    if (GameModel.xOrOList[index] == '') {
      GameModel.xOrOList[index] = GameModel.turnOfO ? 'o' : 'x';
      GameModel.filledBoxes += 1;

      GameModel.turnOfO = !GameModel.turnOfO;

      String? winner = checkWinner();
      return winner;
    }

    return null;
  }

  String? checkWinner() {
    // Draw
    if (GameModel.filledBoxes == 9) {
      return '';
    }

    // ROWS
    for (int i = 0; i <= 6; i += 3) {
      if (GameModel.xOrOList[i] == GameModel.xOrOList[i + 1] &&
          GameModel.xOrOList[i] == GameModel.xOrOList[i + 2] &&
          GameModel.xOrOList[i] != '') {
        return GameModel.xOrOList[i];
      }
    }

    // COLUMNS
    for (int i = 0; i <= 2; i++) {
      if (GameModel.xOrOList[i] == GameModel.xOrOList[i + 3] &&
          GameModel.xOrOList[i] == GameModel.xOrOList[i + 6] &&
          GameModel.xOrOList[i] != '') {
        return GameModel.xOrOList[i];
      }
    }

    // DIAGONS
    // first diagon
    if (GameModel.xOrOList[0] == GameModel.xOrOList[4] &&
        GameModel.xOrOList[0] == GameModel.xOrOList[8] &&
        GameModel.xOrOList[0] != '') {
      return GameModel.xOrOList[0];
    }

    // second diagon
    if (GameModel.xOrOList[2] == GameModel.xOrOList[4] &&
        GameModel.xOrOList[2] == GameModel.xOrOList[6] &&
        GameModel.xOrOList[2] != '') {
      return GameModel.xOrOList[2];
    }

    return null;
  }

  void outputWinner(String title, String winner, VoidCallback onOkPressed) {
    showAlertDialog(
        context: context,
        title: title,
        content: winner == ''
            ? 'The match ended in a draw'
            : 'The winner is ${winner.toUpperCase()}',
        defaultActionText: 'OK',
        onOkPressed: () {
          onOkPressed();
          Navigator.of(context).pop();
        });
  }

  void updateScore(String winner) {
    if (winner == 'o') {
      GameModel.scoreO += 1;
    } else if (winner == 'x') {
      GameModel.scoreX += 1;
    }
  }

  String getScoreOString() {
    return GameModel.scoreO.toString();
  }

  String getScoreXString() {
    return GameModel.scoreX.toString();
  }

  bool isOTurn() {
    return GameModel.turnOfO;
  }

  List<String> getBoardList() {
    return GameModel.xOrOList;
  }
}
