// ignore_for_file: prefer_const_constructors,  prefer_const_literals_to_create_immutables

import 'package:bytebank/database/app/database.dart';
import 'package:bytebank/models/contact.dart';
import 'package:bytebank/screens/contacts/form.dart';
import 'package:flutter/material.dart';

class ContactsList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Contatos"),
      ),
      body: FutureBuilder<List<Contact>>(
        initialData: [],
        future: Future.delayed(Duration(seconds: 0)).then(((value) => findAll())), // FutureBuilder tenta executar a busca de contatos no banco de dados e modifica o código no callback
        builder: (context, snapshot) {
          final List<Contact>? contacts = snapshot.data;
          return ListView.builder(
            itemBuilder: (context, index) {
              final Contact contact = contacts![index];
              return _ContactItem(contact);
            },
            itemCount: contacts?.length,
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(builder: (context) => ContactForm())).then((novoContato) => debugPrint(novoContato.toString()));
        },
        child: Icon(Icons.add),
      ),
    );
  }
}

class _ContactItem extends StatelessWidget {
  final Contact contact;
  _ContactItem(this.contact);
  @override
  Widget build(Object context) {
    return Card(
      child: ListTile(
        title: Text(
          contact.nome,
          style: TextStyle(fontSize: 24.0),
        ),
        subtitle: Text(contact.numeroDaConta.toString(), style: TextStyle(fontSize: 16.0)),
      ),
    );
  }
}
