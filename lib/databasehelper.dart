import 'dart:typed_data';

import 'package:mysql1/mysql1.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance =
  DatabaseHelper._internal();

  factory DatabaseHelper() {
    return _instance;
  }

  DatabaseHelper._internal();

  MySqlConnection? _connection;

  Future<MySqlConnection> get connection async {

      _connection = await MySqlConnection.connect(ConnectionSettings(
        host:'10.0.2.2',
        port: 3306,
        db: 'medecin',
        user: 'root',
      ));

    return _connection!;
  }

 void insert(String table, Map<String, dynamic> values) async {
    final conn = await connection;
    final result = await conn.query(
        'INSERT INTO $table (${values.keys.join(',')}) VALUES (${List.filled(values.length, '?').join(',')})',
        values.values.toList());

  }

  void update(String table, Map<String, dynamic> values,
      String idColumn, int idValue) async {
    final conn = await connection;
    final List<dynamic> valuesList = values.values.toList();
    valuesList.add(idValue);
    final result = await conn.query(
        'UPDATE $table SET ${values.keys.map((key) => '$key = ?').join(',')} WHERE $idColumn = ?',
        valuesList);

  }
  void updateProfilePhoto(String table, Uint8List image,
      String idColumn, int? idValue) async {
    final conn = await connection;
    final result = await conn.query(
        'UPDATE $table SET photo_profil = ? WHERE $idColumn = ?',
        [image, idValue]);
  }

  void deleteRow(
      String table, String idColumn, int idValue) async {
    final conn = await connection;
    final result = await conn.query(
        'DELETE FROM $table WHERE $idColumn = ?', [idValue]);

  }
}
