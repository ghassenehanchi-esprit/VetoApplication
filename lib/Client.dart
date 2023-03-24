class Client {
  int? _id;
  String _nom;
  String _prenom;
  String _telephone;
  String _email;
  String _password;
  String _adresse;
  String _ville;

  Client({
    required String nom,
    required String prenom,
    required String telephone,
    required String email,
    required  String password,
    required String adresse,
    required String ville,
  })  : _nom = nom,
        _prenom = prenom,
        _telephone = telephone,
        _email = email,
        _password = password,
        _adresse = adresse,
        _ville = ville;

  Client.fromData(Map<String, dynamic> data)
      : _id = data['id'],
        _nom = data['nom'],
        _prenom = data['prenom'],
        _telephone = data['telephone'],
        _email = data['email'],
        _password = data['password'],
        _adresse = data['adresse'],
        _ville = data['ville'];

  Client.withAllData({
    required int id,
    required String nom,
    required String prenom,
    required String telephone,
    required String email,
    required String password,
    required String adresse,
    required String ville,
  })  : _id = id,
        _nom = nom,
        _prenom = prenom,
        _telephone = telephone,
        _email = email,
        _password = password,
        _adresse = adresse,
        _ville = ville;

  int? get id => _id;

  set id(int? value) {
    _id = value;
  }

  String get nom => _nom;

  set nom(String value) {
    _nom = value;
  }

  String get prenom => _prenom;

  set prenom(String value) {
    _prenom = value;
  }

  String get telephone => _telephone;

  set telephone(String value) {
    _telephone = value;
  }

  String get email => _email;

  set email(String value) {
    _email = value;
  }

  String get password => _password;

  set password(String value) {
    _password = value;
  }

  String get adresse => _adresse;

  set adresse(String value) {
    _adresse = value;
  }

  String get ville => _ville;

  set ville(String value) {
    _ville = value;
  }
}
