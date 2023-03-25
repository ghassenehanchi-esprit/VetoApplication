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

  void insertRendezVous(RendezVous rendezVous) async {
    final conn = await dbHelper.connection;
    final result = await conn.query(
      'INSERT INTO $_tableName ($_columnMedecinId, $_columnClientId, $_columnDate, $_columnPrix, $_columnEstPaye) VALUES (?, ?, ?, ?, ?, ?)',
      [rendezVous.idMedecin, rendezVous.idClient, rendezVous.date, rendezVous.prix, rendezVous.estPaye],
    );

  }

  Future<List<RendezVous>> fetchRendezVous() async {
    final conn = await dbHelper.connection;
    final results = await conn.query('SELECT * FROM $_tableName');
    return results.map((row) => RendezVous.fromMap(row.fields)).toList();
  }

  void updateRendezVous(RendezVous rendezVous) async {
    final conn = await dbHelper.connection;
    final result = await conn.query(
      'UPDATE $_tableName SET $_columnMedecinId = ?, $_columnClientId = ?, $_columnDate = ?, $_columnPrix = ?, $_columnEstPaye = ? WHERE $_columnId = ?',
      [rendezVous.idMedecin, rendezVous.idClient, rendezVous.date, rendezVous.prix, rendezVous.estPaye, rendezVous.id],
    );
  }

  void deleteRendezVous(int id) async {
    final conn = await dbHelper.connection;
    final result = await conn.query(
      'DELETE FROM $_tableName WHERE $_columnId = ?',
      [id],
    );

  }
}
