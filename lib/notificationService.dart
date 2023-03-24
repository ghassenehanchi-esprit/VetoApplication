import 'package:mysql1/mysql1.dart';
import 'package:vetoapplication/databasehelper.dart';
import 'package:vetoapplication/notification.dart';

class NotificationService {
  final _tableName = 'Notification';
  final _columnId = 'idNotification';
  final _columnVeterinaireId = 'idVeterinaire';
  final _columnClientId = 'idClient';
  final _columnMessage = 'message';
  final _columnDateNotification = 'dateNotification';

  final dbHelper = DatabaseHelper();

  Future<int> insertNotification(Notification notification) async {
    return await dbHelper.insert(
      _tableName,
      notification.toMap(),
    );
  }

  Future<List<Notification>> fetchNotifications() async {
    final conn = await dbHelper.connection;
    final results = await conn.query('SELECT * FROM $_tableName');
    return results.map((row) => Notification.fromMap(row.fields)).toList();
  }

  Future<int> updateNotification(Notification notification) async {
    return await dbHelper.update(
      _tableName,
      notification.toMap(),
      _columnId,
      notification.id,
    );
  }

  Future<int> deleteNotification(int id) async {
    return await dbHelper.deleteRow(
      _tableName,
      _columnId,
      id,
    );
  }
}
