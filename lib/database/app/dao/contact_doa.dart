import 'package:bytebank/database/app/database.dart';
import 'package:bytebank/models/contact.dart';
import 'package:sqflite/sqflite.dart';

class ContactDao {
  static const String _tableName = 'contatos';
  static const String _id = 'id';
  static const String _nome = 'nome';
  static const String _numeroDaConta = 'numeroDaConta';

  static const String tableSql = 'CREATE TABLE contatos ('
      '$_id INTEGER PRIMARY KEY, '
      '$_nome TEXT, '
      '$_numeroDaConta INTEGER'
      ')';

  Future<int> save(Contact contact) async {
    final Database db = await getDatabase();
    Map<String, dynamic> contactMap = _toMap(contact);
    return db.insert(_tableName, contactMap);
  }

  Map<String, dynamic> _toMap(Contact contact) {
    final Map<String, dynamic> contactMap = {};
    contactMap[_nome] = contact.nome;
    contactMap[_numeroDaConta] = contact.numeroDaConta;
    return contactMap;
  }

  /// Varremos todos os itens do db para termos nossa lista de contatos
  Future<List<Contact>> findAll() async {
    final Database db = await getDatabase();
    final List<Map<String, dynamic>> result = await db.query(_tableName);
    List<Contact> contatos = _toList(result);
    return contatos;
  }

  List<Contact> _toList(List<Map<String, dynamic>> result) {
    final List<Contact> contatos = [];
    for (Map<String, dynamic> row in result) {
      final Contact contact = Contact(
        row[_id],
        row[_nome],
        row[_numeroDaConta],
      );
      contatos.add(contact);
    }
    return contatos;
  }
}
