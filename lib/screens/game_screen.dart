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
  int diceSum = 0;
  int target = 12;

  void gameOff() {
    setState(() {
      widget.noPlayNotifier.value = true;
    });
  }

  void rollDice() {
    const duration =
        Duration(milliseconds: 100); // Update interval for the looping effect
    const totalDuration =
        Duration(seconds: 1); // Total duration of the looping effect

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
        diceSum = index1 + index2 + 2;
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
              "Dice Sum: " + diceSum.toString(),
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),
          SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.only(
              left: 10,
              right: 10,
              bottom: 20,
            ),
            child: Column(
              children: [
                if (diceSum == 11)
                  Text(
                    "Congratulations, You are the Winner!",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Colors.green,
                    ),
                  ),
                if (diceSum == 12)
                  Text(
                    "Sorry, you are the loser!",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Colors.red,
                    ),
                  ),
                if (diceSum <= target &&
                    diceSum != 0 &&
                    target != 1 &&
                    diceSum != 11 &&
                    diceSum != 12)
                  Text(
                    "Try Again",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
              ],
            ),
          ),
          diceSum != 11 || diceSum == 0
              ? MyButton(
                  text: "Roll",
                  callback: rollDice,
                  color: Colors.red,
                  weight: FontWeight.bold,
                  fontSize: 20,
                )
              : MyButton(
                  text: "Reset",
                  callback: gameOff,
                  color: Colors.red,
                  weight: FontWeight.bold,
                  fontSize: 20,
                ),
        ],
      ),
    );
  }
}
