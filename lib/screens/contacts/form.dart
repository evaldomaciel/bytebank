import 'package:bytebank/database/app/dao/contact_doa.dart';
import 'package:bytebank/models/contact.dart';
import 'package:flutter/material.dart';

class ContactForm extends StatefulWidget {
  const ContactForm({super.key});

  @override
  State<ContactForm> createState() => _ContactFormState();
}

class _ContactFormState extends State<ContactForm> {
  final TextEditingController _name = TextEditingController();
  final TextEditingController _accountNumberController = TextEditingController();
  final ContactDao _dao = ContactDao();
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
                controller: _name,
                decoration: const InputDecoration(
                  label: Text('Nome completo'),
                ),
                style: const TextStyle(
                  fontSize: 24.0,
                ),
              ),
            ),
            TextField(
              controller: _accountNumberController,
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
                    final String fullName = _name.text;
                    final int? accountNumber = int.tryParse(_accountNumberController.text);
                    final Contact novoContato = Contact(0, fullName, accountNumber);
                    _dao.save(novoContato).then((id) {
                      setState(() => Navigator.pop(context));
                    });
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
