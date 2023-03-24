import 'package:mysql1/mysql1.dart';
import 'package:vetoapplication/commentaire.dart';
import 'package:vetoapplication/databasehelper.dart';

class CommentaireService {
  final _tableName = 'Commentaire';
  final _columnId = 'idCommentaire';
  final _columnMedecinId = 'idMedecin';
  final _columnClientId = 'idClient';
  final _columnCommentaire = 'commentaire';
  final _columnNote = 'note';
  final _columnDate = 'dateCommentaire';

  final dbHelper = DatabaseHelper();

  Future<int> insertCommentaire(Commentaire commentaire) async {
    return await dbHelper.insert(
      _tableName,
      commentaire.toMap(),
    );
  }

  Future<List<Commentaire>> fetchCommentaires() async {
    final conn = await dbHelper.connection;
    final results = await conn.query('SELECT * FROM $_tableName');
    return results.map((row) => Commentaire.fromMap(row.fields)).toList();
  }

  Future<int> updateCommentaire(Commentaire commentaire) async {
    return await dbHelper.update(
      _tableName,
      commentaire.toMap(),
      _columnId,
      commentaire.id,
    );
  }

  Future<int> deleteCommentaire(int id) async {
    return await dbHelper.deleteRow(
      _tableName,
      _columnId,
      id,
    );
  }
}
