import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:mysql1/mysql1.dart';
import 'package:vetoapplication/Client.dart';
import 'package:vetoapplication/databasehelper.dart';

class ClientService {
  final _tableName = 'client';
  final _columnId = 'idClient';
  final _columnName = 'nomClient';
  final _columnPrenom = 'prenomClient';
  final _columnTelephone = 'telClient';
  final _columnEmail = 'emailClient';
  final _columnPassword = 'passwordClient';
  final _columnAdresse = 'adresseClient';
  final _columnVille = 'villeClient';
  Future<Results> getImageClient(int? id) async{
    final conn = await DatabaseHelper().connection;
    final results = await conn.query('SELECT photo_profil FROM client WHERE idClient= ?',[id]);
    return results;
  }


  void insertClient(Client client) async {
    final conn = await DatabaseHelper().connection;
    await conn.query(
        'INSERT INTO $_tableName ($_columnName, $_columnPrenom, $_columnTelephone, $_columnEmail, $_columnPassword, $_columnAdresse, $_columnVille) VALUES (?, ?, ?, ?, ?, ?, ?)',
        [client.nom, client.prenom, client.telephone, client.email, client.password, client.adresse, client.ville]);
  }

  Future<List> fetchClients() async {
    final conn = await DatabaseHelper().connection;
    final results = await conn.query('SELECT * FROM $_tableName');
    return results.map((row) => Client.fromData(row.fields)).toList();
  }

  void updateClient(Client client) async {
    final conn = await DatabaseHelper().connection;
    await conn.query(
        'UPDATE $_tableName SET $_columnName = ?, $_columnPrenom = ?, $_columnTelephone = ?, $_columnEmail = ?, $_columnPassword = ?, $_columnAdresse = ?, $_columnVille = ? WHERE $_columnId = ?',
        [client.nom!, client.prenom!, client.telephone!, client.email!, client.password!, client.adresse!, client.ville!, client.id!]);
  }

  void deleteClient(int id) async {
    final conn = await DatabaseHelper().connection;
    await conn.query('DELETE FROM $_tableName WHERE $_columnId = ?', [id]);
  }

}
