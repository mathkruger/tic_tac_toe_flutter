class GameModel {
  int _scoreX = 0;
  int _scoreO = 0;
  bool _turnOfO = true;
  int _filledBoxes = 0;
  final List<String> _xOrOList = ['', '', '', '', '', '', '', '', ''];

  get scoreX => _scoreX;
  set scoreX(value) => _scoreX = value;

  get scoreO => _scoreO;
  set scoreO(value) => _scoreO = value;

  get turnOfO => _turnOfO;
  set turnOfO(value) => _turnOfO = value;

  get filledBoxes => _filledBoxes;
  set filledBoxes(value) => _filledBoxes = value;

  get xOrOList => _xOrOList;

  void restart() {
    scoreO = 0;
    scoreX = 0;
    turnOfO = true;
    filledBoxes = 0;

    for (int i = 0; i < xOrOList.length; i++) {
      xOrOList[i] = '';
    }
  }
}
