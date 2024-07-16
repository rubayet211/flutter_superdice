import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:super_roll/home.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Home(),
      theme: ThemeData(textTheme: GoogleFonts.russoOneTextTheme()),
    );
  }
}