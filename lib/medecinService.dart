import 'package:vetoapplication/databasehelper.dart';
import 'package:vetoapplication/medecin.dart';
import 'package:mysql1/mysql1.dart';

class MedecinService {
  final _tableName = 'medecin';
  final _columnId = 'idMedecin';
  final _columnName = 'nomMedecin';
  final _columnPrenom = 'prenomMedecin';
  final _columnSpecialite = 'specialiteMedecin';
  final _columnTelephone = 'telMedecin';
  final _columnEmail = 'emailMedecin';
  final _columnPassword = 'passwordMedecin';
  final _columnAdresse = 'adresseMedecin';
  final _columnVille = 'villeMedecin';

  void insertMedecin(Medecin medecin) async {
    final conn = await DatabaseHelper().connection;
    final result = await conn.query(
        'INSERT INTO $_tableName ($_columnName, $_columnPrenom, $_columnSpecialite, $_columnTelephone, $_columnEmail, $_columnPassword, $_columnAdresse, $_columnVille) '
            'VALUES (?, ?, ?, ?, ?, ?, ?, ?)',
        [
          medecin.nom,
          medecin.prenom,
          medecin.specialite,
          medecin.telephone,
          medecin.email,
          medecin.password,
          medecin.adresse,
          medecin.ville
        ]);
    if(result.insertId != null) {
      print('Medecin inserted successfully with id ${result.insertId}');
    } else {
      print('Error inserting Medecin');
    }
  }
  Future<List<Medecin>> fetchMedecins() async {
    try {
      final conn = await DatabaseHelper().connection;
      final results = await conn.query('SELECT idMedecin,nomMedecin,prenomMedecin,specialiteMedecin,telMedecin,emailMedecin,passwordMedecin,adresseMedecin,villeMedecin FROM $_tableName');
      final medecins =
      results.map((row) => Medecin.fromData(row.fields)).toList();
      print('Fetched ${medecins.length} Medecins');
      return medecins;
    } catch (e) {
      print('Error fetching Medecins: $e');
      return []; // return an empty list if there is an error
    }
  }


  void updateMedecin(Medecin medecin) async {
    final conn = await DatabaseHelper().connection;
    final result = await conn.query(
        'UPDATE $_tableName SET $_columnName = ?, $_columnPrenom = ?, $_columnSpecialite = ?, $_columnTelephone = ?, $_columnEmail = ?, $_columnPassword = ?, $_columnAdresse = ?, $_columnVille = ? WHERE $_columnId = ?',
        [
          medecin.nom,
          medecin.prenom,
          medecin.specialite,
          medecin.telephone,
          medecin.email,
          medecin.password,
          medecin.adresse,
          medecin.ville,
          medecin.id
        ]);
    if(result.affectedRows != null) {
      print('Medecin updated successfully with id ${medecin.id}');
    } else {
      print('Error updating Medecin with id ${medecin.id}');
    }
  }

  void deleteMedecin(int id) async {
    final conn = await DatabaseHelper().connection;
    final result =
    await conn.query('DELETE FROM $_tableName WHERE $_columnId = ?', [id]);
    if(result.affectedRows != null) {
      print('Medecin deleted successfully with id $id');
    } else {
      print('Error deleting Medecin with id $id');
    }
  }

}
