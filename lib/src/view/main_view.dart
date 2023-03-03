import 'package:flutter/material.dart';

class MainView extends StatelessWidget {
  const MainView({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Navigator.pushNamed(context, '/game');
          },
          child: const Text('Play'),
        ),
      ),
    );
  }
}
