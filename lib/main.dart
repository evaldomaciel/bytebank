// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:bytebank/screens/dashboard.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(ByteBankApp());
}

class ByteBankApp extends StatelessWidget {
  const ByteBankApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: Colors.green[900],
        brightness: Brightness.light,
        colorScheme: ColorScheme(
          brightness: Brightness.light,
          primary: Color.fromARGB(255, 27, 94, 32),
          onPrimary: Colors.white,
          secondary: Color.fromARGB(255, 27, 94, 32),
          onSecondary: Colors.white,
          error: Colors.red,
          onError: Colors.red,
          background: Color.fromARGB(255, 27, 94, 32),
          onBackground: Color.fromARGB(255, 27, 94, 32),
          surface: Color.fromARGB(255, 27, 94, 32),
          onSurface: Color.fromARGB(255, 27, 94, 32),
        ),
      ),
      home: Dashboard(),
    );
  }
}

 