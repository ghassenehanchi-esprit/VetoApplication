import 'package:mysql1/mysql1.dart';
import 'package:vetoapplication/databasehelper.dart';
import 'package:vetoapplication/rendezvous.dart';

class RendezVousService {
  final _tableName = 'RendezVous';
  final _columnId = 'idRendezVous';
  final _columnMedecinId = 'idMedecin';
  final _columnClientId = 'idClient';
  final _columnDate = 'dateRendezVous';
  final _columnPrix = 'prixRendezVous';
  final _columnEstPaye = 'estPaye';

  final dbHelper = DatabaseHelper();

  Future<int> insertRendezVous(RendezVous rendezVous) async {
    final conn = await dbHelper.connection;
    final result = await conn.query(
      'INSERT INTO $_tableName ($_columnMedecinId, $_columnClientId, $_columnDate, $_columnPrix, $_columnEstPaye) VALUES (?, ?, ?, ?, ?, ?)',
      [rendezVous.idVeterinaire, rendezVous.idClient, rendezVous.idAnimal, rendezVous.date, rendezVous.prix, rendezVous.estPaye],
    );
    return result.insertId;
  }

  Future<List<RendezVous>> fetchRendezVous() async {
    final conn = await dbHelper.connection;
    final results = await conn.query('SELECT * FROM $_tableName');
    return results.map((row) => RendezVous.fromMap(row.fields)).toList();
  }

  Future<int> updateRendezVous(RendezVous rendezVous) async {
    final conn = await dbHelper.connection;
    final result = await conn.query(
      'UPDATE $_tableName SET $_columnMedecinId = ?, $_columnClientId = ?, $_columnDate = ?, $_columnPrix = ?, $_columnEstPaye = ? WHERE $_columnId = ?',
      [rendezVous.idVeterinaire, rendezVous.idClient, rendezVous.idAnimal, rendezVous.date, rendezVous.prix, rendezVous.estPaye, rendezVous.id],
    );
    return result.affectedRows;
  }

  Future<int> deleteRendezVous(int id) async {
    final conn = await dbHelper.connection;
    final result = await conn.query(
      'DELETE FROM $_tableName WHERE $_columnId = ?',
      [id],
    );
    return result.affectedRows;
  }
}
