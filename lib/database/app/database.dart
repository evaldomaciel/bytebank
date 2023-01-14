import 'package:bytebank/models/contact.dart';
import 'package:flutter/foundation.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

/// Vamos criar o BD
Future<Database> createDatabase() {
  return getDatabasesPath().then((dbPath) {
    final String path = join(dbPath, 'bytebank.db');
    return openDatabase(
      path,
      onCreate: (db, version) {
        db.execute(
          'CREATE TABLE contatos ('
          'id INTEGER PRIMARY KEY, '
          'nome TEXT, '
          'numeroDaConta INTEGER'
          ')',
        );
      },
      version: 3,
    );
  });
}

/// Para salvar o contato
Future<int> save(Contact contact) {
  return createDatabase().then((db) {
    final Map<String, dynamic> contactMap = {};
    contactMap['nome'] = contact.nome;
    contactMap['numeroDaConta'] = contact.numeroDaConta;
    return db.insert('contatos', contactMap);
  });
}

/// Varremos todos os itens do db para termos nossa lista de contatos
Future<List<Contact>> findAll() {
  return createDatabase().then(
    (db) => db.query('contatos').then((maps) {
      final List<Contact> contatos = [];
      for (Map<String, dynamic> map in maps) {
        final Contact contact = Contact(
          map['id'],
          map['nome'],
          map['numeroDaConta'],
        );
        contatos.add(contact);
      }
      debugPrint(contatos.toString());
      return contatos;
    }),
  );
}
