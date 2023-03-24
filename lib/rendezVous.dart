class RendezVous {
  final int id;
  final int idMedecin;
  final int idClient;

  final DateTime date;
  final double prix;
  final bool estPaye;

  RendezVous({
    required this.id,
    required this.idMedecin,
    required this.idClient,

    required this.date,
    required this.prix,
    required this.estPaye,
  });

  factory RendezVous.fromMap(Map<String, dynamic> map) {
    return RendezVous(
      id: map['idRendezVous'] as int,
      idMedecin: map['idMedecin'] as int,
      idClient: map['idClient'] as int,

      date: DateTime.parse(map['dateRendezVous'] as String),
      prix: map['prixRendezVous'] as double,
      estPaye: map['estPaye'] == 1,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'idRendezVous': id,
      'idMedecin': idMedecin,
      'idClient': idClient,

      'dateRendezVous': date.toIso8601String(),
      'prixRendezVous': prix,
      'estPaye': estPaye ? 1 : 0,
    };
  }
}
