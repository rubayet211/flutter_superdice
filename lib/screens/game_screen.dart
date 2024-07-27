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
  int? target;
  String gameStatus = "";
  bool firstRoll = true;

  void gameOff() {
    setState(() {
      widget.noPlayNotifier.value = true;
    });
  }

  void resetGame() {
    setState(() {
      index1 = 0;
      index2 = 0;
      showDiceSum = false;
      diceSum = 0;
      target = null;
      gameStatus = "";
      firstRoll = true;
    });
  }

  void rollDice() {
    const duration = Duration(milliseconds: 100);
    const totalDuration = Duration(seconds: 1);

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

        if (firstRoll) {
          if (diceSum == 11) {
            gameStatus = "You win!";
          } else if (diceSum == 10 || diceSum == 12) {
            gameStatus = "You lose!";
          } else {
            target = 11 - diceSum;
            gameStatus = "Roll again!";
            firstRoll = false;
          }
        } else {
          if (diceSum == target) {
            gameStatus = "You win!";
          } else if (diceSum > target!) {
            gameStatus = "You lose!";
          } else {
            target = target! - diceSum;
            if (target! == 1) {
              gameStatus = "You lose!";
            } else {
              gameStatus = "Roll again!";
            }
          }
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("SuperRoll"),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: gameOff,
            icon: const Icon(
              Icons.exit_to_app,
            ),
          ),
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Flexible(
            child: Container(),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                diceFaces[index1],
                height: 100,
                width: 100,
              ),
              const SizedBox(
                width: 20,
              ),
              Image.asset(
                diceFaces[index2],
                height: 100,
                width: 100,
              ),
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          if (showDiceSum)
            Text(
              "Dice Sum: $diceSum",
              style: const TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),
          const SizedBox(
            height: 20,
          ),
          if (target != null &&
              gameStatus != "You win!" &&
              gameStatus != "You lose!")
            Text(
              "Target: $target",
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.blue,
              ),
            ),
          const SizedBox(
            height: 20,
          ),
          if (gameStatus.isNotEmpty)
            Text(
              gameStatus,
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
                color: gameStatus.contains("win")
                    ? Colors.green
                    : gameStatus.contains("lose")
                        ? Colors.red
                        : Colors.black,
              ),
            ),
          const SizedBox(
            height: 20,
          ),
          if (gameStatus != "You win!" && gameStatus != "You lose!")
            MyButton(
              text: "Roll",
              callback: rollDice,
              color: Colors.red,
              weight: FontWeight.bold,
              fontSize: 30,
            ),
          if (gameStatus == "You win!" || gameStatus == "You lose!")
            MyButton(
              text: "Reset",
              callback: resetGame,
              color: Colors.red,
              weight: FontWeight.bold,
              fontSize: 30,
            ),
          Flexible(
            child: Container(),
          ),
        ],
      ),
    );
  }
}
