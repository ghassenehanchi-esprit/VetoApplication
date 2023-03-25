import 'package:flutter/material.dart';
import 'package:vetoapplication/CustomBottomNavigationBar.dart';
import 'package:vetoapplication/medecin.dart';
import 'package:vetoapplication/medecinService.dart';

import 'components/DoctorInfoContainer.dart';
import 'databasehelper.dart';

class RendezVous extends StatefulWidget {
  const RendezVous({Key? key}) : super(key: key);

  @override
  State<RendezVous> createState() => _RendezVousState();
}

class _RendezVousState extends State<RendezVous> {
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
  TextEditingController _controller = TextEditingController();
  late Future<List<Medecin>> doctors = Future.value([]);

  @override
  void initState() {
    super.initState();
    fetchDoctors();
  }

  Future<void> fetchDoctors() async {
    final medecinService = MedecinService();
    final fetchedDoctors = await medecinService.fetchMedecins();
    setState(() {
      doctors = Future.value(fetchedDoctors);
    });
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Expanded(
          child: Column(
            children: [

              Text(
                'Prendre un Rendez-vous',
              ),
          Container(
            margin: EdgeInsets.fromLTRB(50,50,50,0),
          decoration: BoxDecoration(
            color: Colors.grey[200],
            borderRadius: BorderRadius.circular(10),
          ),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(8,0,9,0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: InputDecoration(
                      hintText: 'Search...',
                      border: InputBorder.none,
                    ),
                  ),
                ),
                Icon(Icons.search),
              ],

              ),
          ),
          ),
              PopupMenuButton(
                itemBuilder: (BuildContext context) => [
                  PopupMenuItem(
                    child: Text('Filter 1'),
                    value: 'filter1',
                  ),
                  PopupMenuItem(
                    child: Text('Filter 2'),
                    value: 'filter2',
                  ),
                  PopupMenuItem(
                    child: Text('Filter 3'),
                    value: 'filter3',
                  ),
                ],
                onSelected: (value) {
                  // handle filter selection
                },
                child: Text('Filtres'),
              ),
              Expanded(
                child: FutureBuilder<List<Medecin>>(
                  future: fetchMedecins(), // Use the fetchMedecins method to retrieve a list of doctors
                  builder: (BuildContext context, AsyncSnapshot<List<Medecin>> snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      return Center(child: Text('Error loading data.'));
                    } else if (snapshot.hasData && snapshot.data!.isNotEmpty) {
                      return ListView.builder(
                        itemCount: snapshot.data!.length,
                        itemBuilder: (BuildContext context, int index) {
                          final medecin = snapshot.data![index];
                          return DoctorInfoContainer(
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CircleAvatar(
                                  radius: 30,
                                  //backgroundImage: NetworkImage(medecin.photo),
                                ),
                                SizedBox(width: 10),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(

                                        medecin.nom ?? '',
                                        style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Text(
                                        medecin.specialite ?? '',
                                        style: TextStyle(
                                          color: Colors.grey,
                                        ),
                                      ),
                                      Text(
                                        medecin.adresse ?? '',
                                      ),
                                      Text(
                                        'Tél: ${medecin.telephone ?? ''}',
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      );
                    } else {
                      return Center(child: Text('No data found.'));
                    }
                  },
                ),
              ),

            ],
          ),
        ),
      ),
      bottomNavigationBar: CustomBottomNavigationBar(),
    );
  }
}
