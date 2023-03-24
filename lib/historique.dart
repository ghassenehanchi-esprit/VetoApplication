class Historique {
  int id;
  int idMedecin;
  int idClient;
  DateTime dateConsultation;
  String diagnostic;

  Historique({
    required this.id,
    required this.idMedecin,
    required this.idClient,

    required this.dateConsultation,
    required this.diagnostic,
  });

  Map<String, dynamic> toMap() {
    return {
      'idHistorique': id,
      'idMedecin': idMedecin,
      'idClient': idClient,
      'dateConsultation': dateConsultation.toIso8601String(),
      'diagnostic': diagnostic,
    };
  }

  factory Historique.fromMap(Map<String, dynamic> map) {
    return Historique(
      id: map['idHistorique'],
      idMedecin: map['idVeterinaire'],
      idClient: map['idClient'],
      dateConsultation: DateTime.parse(map['dateConsultation']),
      diagnostic: map['diagnostic'],
    );
  }
}
