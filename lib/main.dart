import 'package:flutter/material.dart';
import 'alert_dialog.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.amber,
      ),
      home: const MyHomePage(title: 'Tic Tac Toe'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _scoreX = 0;
  int _scoreO = 0;
  bool _turnOfO = true;
  int _filledBoxes = 0;
  final List<String> _xOrOList = ['', '', '', '', '', '', '', '', ''];

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
    const labelStyle = TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0);

    return Expanded(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                const Text('Player O', style: labelStyle),
                const SizedBox(height: 5),
                Text(_scoreO.toString())
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                const Text('Player X', style: labelStyle),
                const SizedBox(height: 5),
                Text(_scoreX.toString())
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _buildGrid() {
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
                    child: Center(
                      child: Text(_xOrOList[index],
                          style: TextStyle(
                            color: _xOrOList[index] == 'x'
                                ? Colors.blue
                                : Colors.red,
                            fontSize: 40,
                          )),
                    ),
                  ));
            },
          ),
        ));
  }

  Widget _buildTurn() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Center(
        child: Text(
          _turnOfO ? 'Turn of O' : 'Turn of X',
        ),
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
    // ROWS
    // first row
    if (_xOrOList[0] == _xOrOList[1] &&
        _xOrOList[0] == _xOrOList[2] &&
        _xOrOList[0] != '') {
      _showAlertDialog('Winner', _xOrOList[0]);
      return;
    }

    // second row
    if (_xOrOList[3] == _xOrOList[4] &&
        _xOrOList[3] == _xOrOList[5] &&
        _xOrOList[3] != '') {
      _showAlertDialog('Winner', _xOrOList[3]);
      return;
    }

    // third row
    if (_xOrOList[6] == _xOrOList[7] &&
        _xOrOList[6] == _xOrOList[8] &&
        _xOrOList[6] != '') {
      _showAlertDialog('Winner', _xOrOList[6]);
      return;
    }

    // COLUMNS
    // first column
    if (_xOrOList[0] == _xOrOList[3] &&
        _xOrOList[0] == _xOrOList[6] &&
        _xOrOList[0] != '') {
      _showAlertDialog('Winner', _xOrOList[0]);
      return;
    }

    // second column
    if (_xOrOList[1] == _xOrOList[4] &&
        _xOrOList[1] == _xOrOList[7] &&
        _xOrOList[1] != '') {
      _showAlertDialog('Winner', _xOrOList[1]);
      return;
    }

    // third column
    if (_xOrOList[2] == _xOrOList[5] &&
        _xOrOList[2] == _xOrOList[8] &&
        _xOrOList[2] != '') {
      _showAlertDialog('Winner', _xOrOList[2]);
      return;
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

    // Draw
    if (_filledBoxes == 9) {
      _showAlertDialog('Draw', '');
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
