import 'dart:ffi';
import 'dart:ui';

import 'package:flutter/material.dart';

class ContactForm extends StatelessWidget {
  const ContactForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Novo contato')),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: const <Widget>[
            Padding(
              padding: EdgeInsets.only(top: 8.0),
              child: TextField(
                decoration: InputDecoration(
                  label: Text('Nome completo'),
                ),
                style: TextStyle(
                  fontSize: 24.0,
                ),
              ),
            ),
            TextField(
              decoration: InputDecoration(
                label: Text('Número da conta'),
              ),
              style: TextStyle(
                fontSize: 24.0,
              ),
              keyboardType: TextInputType.number,
            ),
            Padding(
              padding: EdgeInsets.only(top: 16.0),
              child: SizedBox(
                width: double.maxFinite,
                child: ElevatedButton(
                  onPressed: null,
                  child: Text("Criar"),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
