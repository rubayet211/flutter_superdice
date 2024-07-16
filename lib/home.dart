import 'package:flutter/material.dart';
import 'package:super_roll/screens/game_screen.dart';
import 'package:super_roll/screens/start_screen.dart';

class Home extends StatelessWidget {
  Home({super.key});

  final ValueNotifier<bool> noPlayNotifier = ValueNotifier<bool>(true);

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: noPlayNotifier,
      builder: (context, noPlay, child) {
        return noPlay ? StartScreen(noPlayNotifier) : GameScreen();
      },
    );
  }
}
