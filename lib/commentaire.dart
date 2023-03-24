class Commentaire {
  final int id;
  final int idMedecin;
  final int idClient;
  final String commentaire;
  final int note;
  final DateTime dateCommentaire;

  Commentaire({
    required this.id,
    required this.idMedecin,
    required this.idClient,
    required this.commentaire,
    required this.note,
    required this.dateCommentaire,
  });

  Map<String, dynamic> toMap() {
    return {
      'idCommentaire': id,
      'idVeterinaire': idMedecin,
      'idClient': idClient,
      'commentaire': commentaire,
      'note': note,
      'dateCommentaire': dateCommentaire.toIso8601String(),
    };
  }

  factory Commentaire.fromMap(Map<String, dynamic> map) {
    return Commentaire(
      id: map['idCommentaire'],
      idMedecin: map['idMedecin'],
      idClient: map['idClient'],
      commentaire: map['commentaire'],
      note: map['note'],
      dateCommentaire: DateTime.parse(map['dateCommentaire']),
    );
  }
}
