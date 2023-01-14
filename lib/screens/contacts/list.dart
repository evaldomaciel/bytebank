// ignore_for_file: prefer_const_constructors,  prefer_const_literals_to_create_immutables, prefer_const_constructors_in_immutables, no_leading_underscores_for_local_identifiers, use_key_in_widget_constructors

import 'package:bytebank/database/app/dao/contact_doa.dart';
import 'package:bytebank/models/contact.dart';
import 'package:bytebank/screens/contacts/form.dart';
import 'package:flutter/material.dart';

class ContactsList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final ContactDao _dao = ContactDao();

    return Scaffold(
      appBar: AppBar(
        title: Text("Transferir"),
      ),
      body: FutureBuilder<List<Contact>>(
        initialData: [],
        future: Future.delayed(Duration(seconds: 1)).then(((value) => _dao.findAll())), // FutureBuilder tenta executar a busca de contatos no banco de dados e modifica o código no callback
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
              break;
            case ConnectionState.waiting:
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [CircularProgressIndicator(), Text("Carregando")],
                ),
              );
            case ConnectionState.active:
              break;
            case ConnectionState.done:
              final List<Contact>? contacts = snapshot.data;
              return ListView.builder(
                itemBuilder: (context, index) {
                  final Contact contact = contacts![index];
                  return _ContactItem(contact);
                },
                itemCount: contacts?.length,
              );
          }
          return Text("Erro no retorno!");
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(builder: (context) => ContactForm()));
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
