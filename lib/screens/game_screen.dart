import 'package:flutter/material.dart';

class GameScreen extends StatefulWidget {
  final ValueNotifier<bool> noPlayNotifier;
  const GameScreen(this.noPlayNotifier, {super.key});

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  void gameOff() {
    setState(() {
      widget.noPlayNotifier.value = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("SuperRoll"),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: gameOff,
            icon: Icon(
              Icons.exit_to_app,
            ),
          ),
        ],
      ),
    );
  }
}
