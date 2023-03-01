import 'package:flutter/material.dart';
import 'alert_dialog.dart';

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
      home: const MainPage(title: 'Tic Tac Toe'),
    );
  }
}

class MainPage extends StatefulWidget {
  const MainPage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _scoreX = 0;
  int _scoreO = 0;
  bool _turnOfO = true;
  int _filledBoxes = 0;
  final List<String> _xOrOList = ['', '', '', '', '', '', '', '', ''];

  final circle = const Image(image: AssetImage('images/circle.png'));
  final cross = const Image(image: AssetImage('images/cross.png'));

  void _clearBoard({bool clearGame = false}) {
    setState(() {
      for (int i = 0; i < _xOrOList.length; i++) {
        _xOrOList[i] = '';
      }
    });

    _filledBoxes = 0;
    _turnOfO = true;

    if (clearGame) {
      _scoreO = 0;
      _scoreX = 0;
    }
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
                Text(_scoreO.toString(), style: textStyle)
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                SizedBox(width: 64, height: 64, child: cross),
                const SizedBox(height: 5),
                Text(_scoreX.toString(), style: textStyle)
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
            itemCount: _xOrOList.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3),
            itemBuilder: (BuildContext context, int index) {
              return GestureDetector(
                  onTap: () {
                    _tapped(index);
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey.shade700)),
                    child: elements[_xOrOList[index]],
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
          _turnOfO
              ? SizedBox(width: 32, height: 32, child: circle)
              : SizedBox(width: 32, height: 32, child: cross),
        ],
      ),
    );
  }

  void _tapped(int index) {
    setState(() {
      if (_xOrOList[index] == '') {
        _xOrOList[index] = _turnOfO ? 'o' : 'x';
        _filledBoxes += 1;

        _turnOfO = !_turnOfO;
        _checkWinner();
      }
    });
  }

  void _checkWinner() {
    // Draw
    if (_filledBoxes == 9) {
      _showAlertDialog('Draw', '');
      return;
    }

    // ROWS
    for (int i = 0; i <= 6; i += 3) {
      if (_xOrOList[i] == _xOrOList[i + 1] &&
          _xOrOList[i] == _xOrOList[i + 2] &&
          _xOrOList[i] != '') {
        _showAlertDialog('Winner', _xOrOList[i]);
        return;
      }
    }

    // COLUMNS
    for (int i = 0; i <= 2; i++) {
      if (_xOrOList[i] == _xOrOList[i + 3] &&
          _xOrOList[i] == _xOrOList[i + 6] &&
          _xOrOList[i] != '') {
        _showAlertDialog('Winner', _xOrOList[i]);
        return;
      }
    }

    // DIAGONS
    // first diagon
    if (_xOrOList[0] == _xOrOList[4] &&
        _xOrOList[0] == _xOrOList[8] &&
        _xOrOList[0] != '') {
      _showAlertDialog('Winner', _xOrOList[0]);
      return;
    }

    // second diagon
    if (_xOrOList[2] == _xOrOList[4] &&
        _xOrOList[2] == _xOrOList[6] &&
        _xOrOList[2] != '') {
      _showAlertDialog('Winner', _xOrOList[2]);
      return;
    }
  }

  void _showAlertDialog(String title, String winner) {
    showAlertDialog(
        context: context,
        title: title,
        content: winner == ''
            ? 'The match ended in a draw'
            : 'The winner is ${winner.toUpperCase()}',
        defaultActionText: 'OK',
        onOkPressed: () {
          _clearBoard();
          Navigator.of(context).pop();
        });

    _updateScore(winner);
  }

  void _updateScore(String winner) {
    if (winner == 'o') {
      _scoreO += 1;
    } else if (winner == 'x') {
      _scoreX += 1;
    }
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
                _clearBoard(clearGame: true);
              }),
        ],
        title: Text(widget.title),
      ),
      body: Column(
        children: [_buildPointsTable(), _buildGrid(), _buildTurn()],
      ),
    );
  }
}
