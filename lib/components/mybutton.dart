import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  final String text;
  final VoidCallback? callback;
  final Color color;
  final FontWeight weight;
  final double fontSize;
  const MyButton(
      {super.key,
      required this.text,
      required this.callback,
      required this.color,
      required this.weight,
      required this.fontSize});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: callback,
      style: ButtonStyle(
        backgroundColor: WidgetStateProperty.all<Color>(Colors.black),
        padding: WidgetStateProperty.all<EdgeInsetsGeometry>(
          const EdgeInsets.symmetric(vertical: 10, horizontal: 30),
        ),
        shape: WidgetStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: color,
          fontWeight: weight,
          fontSize: fontSize,
        ),
      ),
    );
  }
}
