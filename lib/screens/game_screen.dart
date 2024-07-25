import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:super_roll/components/mybutton.dart';

class GameScreen extends StatefulWidget {
  final ValueNotifier<bool> noPlayNotifier;
  const GameScreen(this.noPlayNotifier, {super.key});

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  final diceFaces = [
    "assets/dice-six-faces-one.png",
    "assets/dice-six-faces-two.png",
    "assets/dice-six-faces-three.png",
    "assets/dice-six-faces-four.png",
    "assets/dice-six-faces-five.png",
    "assets/dice-six-faces-six.png",
  ];

  int index1 = 0;
  int index2 = 0;
  final random = Random.secure();
  Timer? timer;
  bool showDiceSum = false;

  void gameOff() {
    setState(() {
      widget.noPlayNotifier.value = true;
    });
  }

  void rollDice() {
    const duration =
        Duration(milliseconds: 100); // Update interval for the looping effect
    const totalDuration =
        Duration(seconds: 2); // Total duration of the looping effect

    timer?.cancel();
    timer = Timer.periodic(duration, (Timer t) {
      setState(() {
        index1 = random.nextInt(6);
        index2 = random.nextInt(6);
      });
    });

    Future.delayed(totalDuration, () {
      timer?.cancel();
      setState(() {
        index1 = random.nextInt(6);
        index2 = random.nextInt(6);
        showDiceSum = true;
      });
    });
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
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
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                diceFaces[index1],
                height: 100,
                width: 100,
              ),
              SizedBox(
                width: 20,
              ),
              Image.asset(
                diceFaces[index2],
                height: 100,
                width: 100,
              ),
            ],
          ),
          SizedBox(
            height: 20,
          ),
          if (showDiceSum)
            Text(
              "Dice Sum",
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),
          SizedBox(
            height: 20,
          ),
          MyButton(
            text: "Roll",
            callback: rollDice,
            color: Colors.red,
            weight: FontWeight.bold,
            fontSize: 20,
          ),
        ],
      ),
    );
  }
}
