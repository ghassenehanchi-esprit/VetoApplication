import 'package:vetoapplication/abonnement.dart';
import 'package:vetoapplication/databasehelper.dart';

class AbonnementService {
  final DatabaseHelper dbHelper;
  final String _tableName = 'Abonnement';
  final String _columnId = 'idAbonnement';

  AbonnementService(this.dbHelper);

  void insertAbonnement(Abonnement abonnement) async {
     await DatabaseHelper().insert(
      _tableName,
      abonnement.toMap(),
    );
  }

  Future<List<Abonnement>> fetchAbonnements() async {
    final conn = await DatabaseHelper().connection;
    final results = await conn.query('SELECT * FROM $_tableName');
    return results.map((row) => Abonnement.fromMap(row.fields)).toList();
  }

  void updateAbonnement(Abonnement abonnement) async {
    await DatabaseHelper().update(
      _tableName,
      abonnement.toMap(),
      _columnId,
      abonnement.id,
    );
  }

  void deleteAbonnement(int id) async {
     await dbHelper.deleteRow(
      _tableName,
      _columnId,
      id,
    );
  }
}
