import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import 'Usuario.dart';

class Banco {
  Future<Database> createDatabase() {
    return getDatabasesPath().then((dbPath) {
      //caminho do bd
      final String path = join(dbPath, 'xpress.db');
      return openDatabase(path, onCreate: (db, version) {
        db.execute('CREATE TABLE usuario ('
            'id INTEGER PRIMARY KEY, '
            'nome TEXT, '
            'cpf_usuario INTEGER, '
            'telefone INTEGER, '
            'email TEXT, '
            'senha TEXT)');
      },
          version:
              1 /*,
    em caso de eliminar dados de versões, quando se tem mais de uma
      onDowngrade: onDatabaseDowngradeDelete,*/
          );
    });
  }

//salva com um id de inserção no bd
  Future<int> save(Usuario usuario) {
    return createDatabase().then((db) {
      final Map<String, dynamic> usuarioMap = Map();
      usuarioMap['nome'] = usuario.nome;
      usuarioMap['cpf_usuario'] = usuario.cpfUsuario;
      usuarioMap['telefone'] = usuario.telefone;
      usuarioMap['email'] = usuario.email;
      usuarioMap['senha'] = usuario.senha;
      return db.insert('usuario', usuarioMap);
    });
  }

  Future<List<Usuario>> findAll() {
    return createDatabase().then((db) {
      return db.query('usuario').then((maps) {
        // ignore: deprecated_member_use
        final List<Usuario> usuarios = List();
        for (Map<String, dynamic> map in maps) {
          final Usuario usuario = Usuario(map['id'], map['nome'],
              map['cpf_usuario'], map['telefone'], map['email'], map['senha']);
          usuarios.add(usuario);
        }
        return usuarios;
      });
    });
  }

  Future<bool> findOne(Usuario usuario) {
    return createDatabase().then((db) {
      return db.query('usuario').then((maps) {
        // ignore: deprecated_member_use
        final List<Usuario> usuarios = List();
        for (Map<String, dynamic> map in maps) {
          usuario = Usuario(map['id'], map['nome'], map['cpf_usuario'],
              map['telefone'], map['email'], map['senha']);
          usuarios.firstWhere((usuario) => true);
        }
        return true;
      });
    });
  }

  Future<bool> verificaUsuario(where) {
    return createDatabase().then((db) async {
      List<Map> items = await db.query('usuario',
          where: 'email =?', whereArgs: [where], limit: 1);
      if (items.isNotEmpty) {
        items.firstWhere((where) => true);
        return true;
      } else {
        return false;
      }
    });
  }

  Future<bool> verificaSenha(where) {
    return createDatabase().then((db) async {
      List<Map> items = await db.query('usuario',
          where: 'senha =?', whereArgs: [where], limit: 1);
      if (items.isNotEmpty) {
        items.firstWhere((where) => true);
        return true;
      } else {
        return false;
      }
    });
  }

/*
  para testar a inserção


  save(Usuario('admin', 12345678912, 123456789, 'admin@teste.com.br')).then((id){
    findAll().then((usuarios) => debugPrint(Usuarios.toString()));
  });
*/
}
