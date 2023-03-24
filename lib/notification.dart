class Notification {
  int id;
  int idMedecin;
  int idClient;
  String message;
  DateTime dateNotification;

  Notification({
    required this.id,
    required this.idMedecin,
    required this.idClient,
    required this.message,
    required this.dateNotification,
  });

  factory Notification.fromMap(Map<String, dynamic> map) {
    return Notification(
      id: map['idNotification'],
      idMedecin: map['idVeterinaire'],
      idClient: map['idClient'],
      message: map['message'],
      dateNotification: DateTime.parse(map['dateNotification']),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'idNotification': id,
      'idMedecin': idMedecin,
      'idClient': idClient,
      'message': message,
      'dateNotification': dateNotification.toIso8601String(),
    };
  }
}
