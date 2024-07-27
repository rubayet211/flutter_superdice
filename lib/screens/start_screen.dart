import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:super_roll/components/myalert.dart';
import 'package:super_roll/components/mybutton.dart';

class StartScreen extends StatefulWidget {
  final ValueNotifier<bool> noPlayNotifier;

  const StartScreen(this.noPlayNotifier, {super.key});

  @override
  State<StartScreen> createState() => _StartScreenState();
}

class _StartScreenState extends State<StartScreen> {
  void gameOn() {
    setState(() {
      widget.noPlayNotifier.value = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/blackdice.png',
              height: 150,
              width: 300,
            ),
            RichText(
              text: TextSpan(
                text: "Super",
                style: GoogleFonts.russoOne().copyWith(
                  fontSize: 40,
                  color: Colors.black,
                ),
                children: [
                  TextSpan(
                    text: "Roll",
                    style: GoogleFonts.russoOne().copyWith(
                      fontSize: 40,
                      color: Colors.red,
                    ),
                  ),
                ],
              ),
            ),
            Image.asset(
              'assets/reddice.png',
              height: 150,
              width: 300,
            ),
            const SizedBox(
              height: 30,
            ),
            MyButton(
              text: "Start",
              callback: gameOn,
              color: Colors.white,
              weight: FontWeight.bold,
              fontSize: 20,
            ),
            const SizedBox(
              height: 30,
            ),
            MyButton(
              text: "How To Play",
              callback: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) => const NyAlert(),
                );
              },
              color: Colors.white,
              weight: FontWeight.bold,
              fontSize: 20,
            ),
          ],
        ),
      ),
    );
  }
}
