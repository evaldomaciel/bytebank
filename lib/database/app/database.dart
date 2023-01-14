import 'package:bytebank/models/contact.dart';
import 'package:flutter/foundation.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

/// Vamos criar o BD
Future<Database> getDatabase() async {
  final String path = join(await getDatabasesPath(), 'bytebank.db');
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
    version: 1,
    // onDowngrade: onDatabaseDowngradeDelete, /// possibilidade para limpar o banco de dados
  );
}

/// Para salvar o contato
Future<int> save(Contact contact) async {
  final Database db = await getDatabase();
  final Map<String, dynamic> contactMap = {};
  contactMap['nome'] = contact.nome;
  contactMap['numeroDaConta'] = contact.numeroDaConta;
  return db.insert('contatos', contactMap);
}

/// Varremos todos os itens do db para termos nossa lista de contatos
Future<List<Contact>> findAll() async {
  final Database db = await getDatabase();
  final List<Map<String, dynamic>> result = await db.query('contatos');
  final List<Contact> contatos = [];
  for (Map<String, dynamic> row in result) {
    final Contact contact = Contact(
      row['id'],
      row['nome'],
      row['numeroDaConta'],
    );
    contatos.add(contact);
  }
  return contatos;
}
