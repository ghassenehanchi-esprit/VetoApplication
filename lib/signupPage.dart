
import 'dart:math';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:vetoapplication/components/CustomButton.dart';
import 'package:vetoapplication/databasehelper.dart';
import 'package:vetoapplication/medecin.dart';
import 'package:vetoapplication/Client.dart';
import 'package:vetoapplication/medecinService.dart';
import 'package:vetoapplication/clientService.dart';
import 'package:vetoapplication/xdi_phone8_s_e1.dart';
import './xd_composant11.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';
import 'dart:convert';
import 'package:crypto/crypto.dart';

import 'components/CustomTextField.dart';

class SignupPage extends StatefulWidget {
  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  String _selectedRole = 'Client';
  String _selectedSpeciality = 'Cardiologue';

  final TextEditingController _nomController = TextEditingController();
  final TextEditingController _prenomController = TextEditingController();
  final TextEditingController _telController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _adresseController = TextEditingController();
  final TextEditingController _villeController = TextEditingController();
  final RegExp emailRegExp = RegExp(
      r'^[a-zA-Z0-9.!#$%&\*+/=?^_`{|}~-]+@[a-zA-Z0-9-]+(?:\.[a-zA-Z0-9-]+)*$',
  );
  final RegExp passwordRegExp = RegExp(
    r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$',
  );
  final List<String> _specialities = [
    'Cardiologue',
    'Dermatologue',
    'Gynécologue',
    'Ophtalmologue',
    'ORL',
    'Pédiatre',
    'Psychiatre',
    'Rhumatologue'
  ];
  final _formKey = GlobalKey<FormState>();




  String generateValidationLink(String email) {
    // Créer une chaîne aléatoire de 16 caractères
    final random = Random.secure();
    final bytes = List.generate(16, (i) => random.nextInt(256));
    final randomString = base64Url.encode(bytes);

    // Hacher l'email avec SHA-256
    final emailBytes = utf8.encode(email);
    final hash = sha256.convert(emailBytes);

    // Combinez la chaîne aléatoire et le hachage pour créer un lien unique
    final link = 'https://medecin-772dc.web.app/validate?email=$email&token=$randomString&hash=$hash';

    return link;
  }

  Future<void> sendValidationEmail(String userEmail, String validationLink) async {
    final smtpServer = gmail('ghasseneclubiste456@gmail.com', 'tmdyqqjuxgqwulaf');
    final message = Message()
      ..from = Address('ghasseneclubiste456@gmail.com', 'medecinapplication')
      ..recipients.add(userEmail)
      ..subject = 'Validate your account'
      ..html = '''
      <p>Thank you for creating an account.</p>
      <p>Please click on the following link to validate your account:</p>
      <p><a href="$validationLink">$validationLink</a></p>
    ''';
    try {
      final sendReport = await send(message, smtpServer);
      print('Message sent: ${sendReport.messageSendingEnd}');
    } on MailerException catch (e) {
      print('Message not sent: $e');
    }
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFF42F1A6), Color(0xFF6f76fc)],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(height: 50),

                GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: const Icon(Icons.close),
                ),
                const SizedBox(height: 70),
                Container(
                  margin: EdgeInsets.fromLTRB(50, 0, 0, 0),
                  child: const Text(
                    'Inscription',
                    style: TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
                const SizedBox(height: 70),

                CustomTextField(
                  controller: _nomController,
                   hintText: 'Nom',
                  icon: Icons.person_outline,
                ),
                const SizedBox(height: 20),
                CustomTextField(
                  controller: _prenomController,
                  hintText: 'Prénom',
                  icon: Icons.person_outline,
                ),
                const SizedBox(height: 20),
                CustomTextField(
                  controller: _telController,
                  hintText: 'Téléphone',
                  icon: CupertinoIcons.phone,
                ),
                const SizedBox(height: 20),

                CustomTextField(
                    controller: _emailController,
                  hintText: 'E-mail',
                  icon: CupertinoIcons.mail,
                  ),
                const SizedBox(height: 20),
                CustomTextField(
                  controller: _passwordController,
                  hintText: 'Mot de Passe',
                  obscureText: true,
                  icon: Icons.password_rounded,
                ),
                const SizedBox(height: 16),DropdownButtonFormField<String>(
                  value: _selectedRole,
                  decoration: InputDecoration(
                    labelText: 'Rôle',
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                    filled: true,
                    fillColor: Colors.transparent, // set fillColor to transparent
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(24.0),
                      borderSide: BorderSide.none,
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(24.0),
                      borderSide: BorderSide.none,
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(24.0),
                      borderSide: BorderSide.none,
                    ),
                    prefix: Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [Color(0xff42f1a6), Color(0xff6f76fc)],
                          stops: [0.0, 1.0],
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                        ),
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(24.0),
                          bottomLeft: Radius.circular(24.0),
                        ),
                      ),
                      child: Icon(Icons.person_outline, color: Colors.white),
                    ),
                    contentPadding:
                    EdgeInsets.only(top: 16, bottom: 16, left: 16, right: 8),
                  ),
                  items: <String>['Client', 'Médecin']
                      .map((String value) => DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  ))
                      .toList(),
                  onChanged: (String? newValue) {
                    setState(() {
                      _selectedRole = newValue!;
                    });
                  },
                ),

                if (_selectedRole == 'Médecin') ...[
                  const SizedBox(height: 16),
                  DropdownButtonFormField<String>(
                    value: _selectedSpeciality,
                    decoration: const InputDecoration(labelText: 'Spécialité'),
                    items: _specialities
                        .map((String value) => DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    ))
                        .toList(),
                    onChanged: (String? newValue) {
                      setState(() {
                        _selectedSpeciality = newValue!;
                      });
                    },
                  ),
                ],

                CustomTextField(
                  controller: _adresseController,
                  hintText: 'Adresse',
                  icon: Icons.home,
                ),
                const SizedBox(height: 20),

                CustomTextField(
                  controller: _villeController,
                  hintText: 'Ville',
                  icon: Icons.place,
                ),

                const SizedBox(height: 32),

                      CustomButton(
                        text: "S'inscrire",
                        onPressed: () async {

        // Créer un nouvel utilisateur en fonction du type sélectionné
        final utilisateur = _selectedRole == "Client"
              ? Client(
            nom: _nomController.text.trim(),
            prenom: _prenomController.text.trim(),
            telephone: _telController.text.trim(),
            email: _emailController.text.trim(),
            password: _passwordController.text,
            adresse: _adresseController.text.trim(),
            ville: _villeController.text.trim(),
        )
              : Medecin(
            nom: _nomController.text.trim(),
            prenom: _prenomController.text.trim(),
            specialite: _selectedSpeciality.toString().trim(),
            telephone: _telController.text.trim(),
            email: _emailController.text.trim(),
            password: _passwordController.text,
            adresse: _adresseController.text.trim(),
            ville: _villeController.text.trim(),
        );
        try {
            UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
              email: _emailController.text.trim(),
              password: _passwordController.text,
            );
            // Insérer l'utilisateur dans la base de données
            final databaseHelper = DatabaseHelper();
            if (_selectedRole == "Client") {
              ClientService().insertClient(utilisateur as Client);
            } else {
              MedecinService().insertMedecin(utilisateur as Medecin);
            }
            // Afficher un message d'erreur ou de succès en fonction du résultat de l'insertion
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => XDIPhone8SE1()),
            );
        } on FirebaseAuthException catch (e) {
            if (e.code == 'weak-password') {
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('The password provided is too weak.')));
            } else if (e.code == 'email-already-in-use') {
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('The account already exists for that email.')));
            }
        } catch (e) {
            debugPrint(e.toString());
        }
                        },
                      ),
                const SizedBox(height: 20),


              ],
            ),
          ),
        ),
      ),
    );
  }
  static Future<User?> signUp(
      {required String userEmail,
        required String password,
        required BuildContext context}) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: userEmail, password: password);
      return userCredential.user;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('The password provided is too weak.')));
      } else if (e.code == 'email-already-in-use') {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('The account already exists for that email.')));
      }
      return null;
    } catch (e) {
      debugPrint(e.toString());
      return null;
    }
  }
}
