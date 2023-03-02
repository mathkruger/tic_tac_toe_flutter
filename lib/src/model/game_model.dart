class GameModel {
  static int _scoreX = 0;
  static int _scoreO = 0;
  static bool _turnOfO = true;
  static int _filledBoxes = 0;
  static final List<String> _xOrOList = ['', '', '', '', '', '', '', '', ''];

  static get scoreX => _scoreX;
  static set scoreX(value) => _scoreX = value;

  static get scoreO => _scoreO;
  static set scoreO(value) => _scoreO = value;

  static get turnOfO => _turnOfO;
  static set turnOfO(value) => _turnOfO = value;

  static get filledBoxes => _filledBoxes;
  static set filledBoxes(value) => _filledBoxes = value;

  static get xOrOList => _xOrOList;
}
