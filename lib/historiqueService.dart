import 'package:mysql1/mysql1.dart';
import 'package:vetoapplication/databasehelper.dart';
import 'package:vetoapplication/historique.dart';

class HistoriqueService {
  final _tableName = 'Historique';
  final _columnId = 'idHistorique';
  final _columnMedecinId = 'idMedecin';
  final _columnClientId = 'idClient';
  final _columnAnimalId = 'idAnimal';
  final _columnDate = 'dateConsultation';
  final _columnDiagnostic = 'diagnostic';

  final dbHelper = DatabaseHelper();

  void insertHistorique(Historique historique) async {
    return  dbHelper.insert(
      _tableName,
      historique.toMap(),
    );
  }

  Future<List<Historique>> fetchHistoriques() async {
    final conn = await dbHelper.connection;
    final results = await conn.query('SELECT * FROM $_tableName');
    return results.map((row) => Historique.fromMap(row.fields)).toList();
  }
  Future<List<Historique>> fetchHistoriquesByID(int id) async {
    final conn = await dbHelper.connection;
    final results = await conn.query('SELECT * FROM $_tableName WHERE $_columnClientId= ?',
  [id]);
    return results.map((row) => Historique.fromMap(row.fields)).toList();
  }
  Future<List<Historique>> fetchHistoriquesByIDmedecin(int id) async {
    final conn = await dbHelper.connection;
    final results = await conn.query('SELECT * FROM $_tableName WHERE $_columnMedecinId= ?',
        [id]);
    return results.map((row) => Historique.fromMap(row.fields)).toList();
  }

 void updateHistorique(Historique historique) async {
    return dbHelper.update(
      _tableName,
      historique.toMap(),
      _columnId,
      historique.id,
    );
  }

  void deleteHistorique(int id) async {
    return  dbHelper.deleteRow(
      _tableName,
      _columnId,
      id,
    );
  }
}
