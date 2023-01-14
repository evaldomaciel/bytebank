import 'package:bytebank/database/app/dao/contact_doa.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

/// Vamos criar o BD
Future<Database> getDatabase() async {
  final String path = join(await getDatabasesPath(), 'bytebank.db');
  return openDatabase(
    path,
    onCreate: (db, version) {
      db.execute(ContactDao.tableSql);
    },
    version: 1,
    // onDowngrade: onDatabaseDowngradeDelete, /// possibilidade para limpar o banco de dados
  );
}

/// Vamos separar camadas com objetivos específicos.
/// Data Access Object (DAO) - Objeto de acesso aos dados! 
/// A ideia é manter os comportamentos de uma entidade, vamos criar um DAO para essa entidade. 
/// Ou seja, vamos criar um DAO para os nossos contatos
/// Para salvar o contato