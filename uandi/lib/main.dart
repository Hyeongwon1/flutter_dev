import 'package:flutter/material.dart';
import 'package:uandi/screen/home_screen.dart';

void main() {
  runApp(
    MaterialApp(
      theme: ThemeData(
        fontFamily: 'sunFlower',
        textTheme: const TextTheme(
          displayLarge: TextStyle(
              color: Colors.white, fontFamily: 'parisienne', fontSize: 80.0),
          displayMedium: TextStyle(
              color: Colors.white, fontFamily: 'sunflower', fontSize: 30.0),
          bodyLarge: TextStyle(
              color: Colors.white, fontFamily: 'sunflower', fontSize: 20.0),
          bodyMedium: TextStyle(
              color: Colors.white,
              fontFamily: 'sunflower',
              fontSize: 30.0,
              fontWeight: FontWeight.w700),
        ),
      ),
    home: HomeScreen(),
    ),
  );
}
