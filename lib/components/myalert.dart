import 'package:flutter/material.dart';

class NyAlert extends StatelessWidget {
  const NyAlert({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("How To Play"),
      alignment: Alignment.center,
      content: const Text("""
- Click on the dices to roll it.

- If the dices sum shows a 11, you win the game.

- If the dices sum shows a 10 or 12, you will lose the game.

- If the dices sum shows 2-9, then you will get the target.
  Target is the number need to score total of 11 for all rolls.
  
- If new dices sum is equal to target, then you will win.

-If new dices sum is greater or 1 target then game over. 
If not, roll again. The same continues with the target.
"""),
      icon: const Icon(Icons.games),
      backgroundColor: Colors.red.shade50,
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text(
            "Close",
          ),
        ),
      ],
    );
  }
}
