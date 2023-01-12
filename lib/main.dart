// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

void main() {
  runApp(ByteBankApp());
}

class ByteBankApp extends StatelessWidget {
  const ByteBankApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text("Dashboard")),
        body: Column(
          children: <Widget>[
            Image.asset('assets/images/bytebank_logo.png'),
            Container(
              height: 120,
              width: 120,
              color: Color.fromARGB(255, 7, 85, 9),
              child: Column(children: <Widget>[
                Icon(Icons.people),
                Text('Contatos'),
              ],),
            ),
          ],
        ),
      ),
    );
  }
}
