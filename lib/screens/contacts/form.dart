import 'package:bytebank/database/app/database.dart';
import 'package:bytebank/models/contact.dart';
import 'package:flutter/material.dart';

class ContactForm extends StatefulWidget {
  const ContactForm({super.key});

  @override
  State<ContactForm> createState() => _ContactFormState();
}

class _ContactFormState extends State<ContactForm> {
  final TextEditingController _nomeCompletoController = TextEditingController();
  final TextEditingController _numeroDaContaController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Novo contato')),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: TextField(
                controller: _nomeCompletoController,
                decoration: const InputDecoration(
                  label: Text('Nome completo'),
                ),
                style: const TextStyle(
                  fontSize: 24.0,
                ),
              ),
            ),
            TextField(
              controller: _numeroDaContaController,
              decoration: const InputDecoration(
                label: Text('Número da conta'),
              ),
              style: const TextStyle(
                fontSize: 24.0,
              ),
              keyboardType: TextInputType.number,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 16.0),
              child: SizedBox(
                width: double.maxFinite,
                child: ElevatedButton(
                  onPressed: () {
                    final String nomeCompleto = _nomeCompletoController.text;
                    final int? numeroDaConta = int.tryParse(_numeroDaContaController.text);
                    final Contact novoContato = Contact(0, nomeCompleto, numeroDaConta);
                    save(novoContato).then((id) => Navigator.pop(context));
                  },
                  child: const Text("Criar"),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
