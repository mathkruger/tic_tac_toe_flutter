import 'package:flutter/widgets.dart';
import '../common/alert_dialog.dart';
import '../model/game_model.dart';

class GameController {
  GameModel model = GameModel();

  void clearBoard({bool clearGame = false}) {
    for (int i = 0; i < model.xOrOList.length; i++) {
      model.xOrOList[i] = '';
    }

    model.filledBoxes = 0;
    model.turnOfO = true;

    if (clearGame) {
      model.scoreO = 0;
      model.scoreX = 0;
    }
  }

  String? tapped(int index) {
    if (model.xOrOList[index] == '') {
      model.xOrOList[index] = model.turnOfO ? 'o' : 'x';
      model.filledBoxes += 1;

      model.turnOfO = !model.turnOfO;

      String? winner = checkWinner();
      return winner;
    }

    return null;
  }

  String? checkWinner() {
    // Draw
    if (model.filledBoxes == 9) {
      return '';
    }

    // ROWS
    for (int i = 0; i <= 6; i += 3) {
      if (model.xOrOList[i] == model.xOrOList[i + 1] &&
          model.xOrOList[i] == model.xOrOList[i + 2] &&
          model.xOrOList[i] != '') {
        return model.xOrOList[i];
      }
    }

    // COLUMNS
    for (int i = 0; i <= 2; i++) {
      if (model.xOrOList[i] == model.xOrOList[i + 3] &&
          model.xOrOList[i] == model.xOrOList[i + 6] &&
          model.xOrOList[i] != '') {
        return model.xOrOList[i];
      }
    }

    // DIAGONS
    // first diagon
    if (model.xOrOList[0] == model.xOrOList[4] &&
        model.xOrOList[0] == model.xOrOList[8] &&
        model.xOrOList[0] != '') {
      return model.xOrOList[0];
    }

    // second diagon
    if (model.xOrOList[2] == model.xOrOList[4] &&
        model.xOrOList[2] == model.xOrOList[6] &&
        model.xOrOList[2] != '') {
      return model.xOrOList[2];
    }

    return null;
  }

  void outputWinner(BuildContext context, String title, String winner,
      VoidCallback onOkPressed) {
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
      model.scoreO += 1;
    } else if (winner == 'x') {
      model.scoreX += 1;
    }
  }

  String getScoreOString() {
    return model.scoreO.toString();
  }

  String getScoreXString() {
    return model.scoreX.toString();
  }

  bool isOTurn() {
    return model.turnOfO;
  }

  List<String> getBoardList() {
    return model.xOrOList;
  }
}
