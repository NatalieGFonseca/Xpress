import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'Motorista.dart';

class BancoMotorista {
  Future<Database> createDatabase() {
    return getDatabasesPath().then((dbPath) {
      //caminho do bd
      final String path = join(dbPath, 'xpressMotoristas.db');
      return openDatabase(path, onCreate: (db, version) {
        db.execute('CREATE TABLE motorista ('
            'id INTEGER PRIMARY KEY, '
            'nome TEXT, '
            'email TEXT, '
            'cpf_motorista INTEGER, '
            'rg_motorista INTEGER, '
            'telefone INTEGER, '
            'placa TEXT, '
            'modelo TEXT, '
            'cor TEXT, '
            'senha TEXT,'
            'cnh INTEGER)');
      },
          version:
              1 /*,
    em caso de eliminar dados de versões, quando se tem mais de uma
      onDowngrade: onDatabaseDowngradeDelete,*/
          );
    });
  }

//salva com um id de inserção no bd
  Future<int> save(Motoristas motorista) {
    return createDatabase().then((db) {
      final Map<String, dynamic> motoristaMap = Map();
      motoristaMap['nome'] = motorista.nome;
      motoristaMap['cpf_motorista'] = motorista.cpfMotorista;
      motoristaMap['rg_motorista'] = motorista.rgMotorista;
      motoristaMap['telefone'] = motorista.telefone;
      motoristaMap['email'] = motorista.email;
      motoristaMap['placa'] = motorista.placa;
      motoristaMap['modelo'] = motorista.modelo;
      motoristaMap['cor'] = motorista.cor;
      motoristaMap['senha'] = motorista.senha;
      motoristaMap['cnh'] = motorista.cnh;
      return db.insert('motorista', motoristaMap);
    });
  }

  Future<List<Motoristas>> findAll() {
    return createDatabase().then((db) {
      return db.query('motorista').then((maps) {
        // ignore: deprecated_member_use
        final List<Motoristas> motoristas = List();
        for (Map<String, dynamic> map in maps) {
          final Motoristas motorista = Motoristas(
              map['id'],
              map['nome'],
              map['email'],
              map['cpf_motorista'],
              map['rg_motorista'],
              map['telefone'],
              map['placa'],
              map['modelo'],
              map['cor'],
              map['senha'],
              map['cnh']);
          motoristas.add(motorista);
        }
        return motoristas;
      });
    });
  }
}
