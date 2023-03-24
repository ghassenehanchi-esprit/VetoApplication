class Abonnement {
  int id;
  int idMedecin;
  DateTime debutAbonnement;
  DateTime finAbonnement;
  double prixAbonnement;

  Abonnement({
    required this.id,
    required this.idMedecin,
    required this.debutAbonnement,
    required this.finAbonnement,
    required this.prixAbonnement,
  });

  Map<String, dynamic> toMap() {
    return {
      'idAbonnement': id,
      'idMedecin': idMedecin,
      'debutAbonnement': debutAbonnement.toIso8601String(),
      'finAbonnement': finAbonnement.toIso8601String(),
      'prixAbonnement': prixAbonnement,
    };
  }

  static Abonnement fromMap(Map<String, dynamic> map) {
    return Abonnement(
      id: map['idAbonnement'],
      idMedecin: map['idVeterinaire'],
      debutAbonnement: DateTime.parse(map['debutAbonnement']),
      finAbonnement: DateTime.parse(map['finAbonnement']),
      prixAbonnement: map['prixAbonnement'],
    );
  }
}
