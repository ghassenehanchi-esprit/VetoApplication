
import 'dart:math';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
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
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            GestureDetector(
              onTap: () => Navigator.pop(context),
              child: const Icon(Icons.close),
            ),
            const SizedBox(height: 70),
            const Text(
              'Inscription',
              style: TextStyle(
                fontSize: 35,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 70),

            TextFormField(
              controller: _nomController,
              decoration: const InputDecoration(labelText: 'Nom'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Veuillez entrer votre nom';
                }

              },
            ),
            TextFormField(
              controller: _prenomController,
              decoration: const InputDecoration(labelText: 'Prénom'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Veuillez entrer votre prénom';
                }
                return null;
              },
            ),

            TextFormField(
              controller: _telController,
              decoration: const InputDecoration(labelText: 'Téléphone'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Veuillez saisir votre numéro de téléphone.';
                }
                if (!value.startsWith('+216')) {
                  return 'Le numéro de téléphone doit commencer par +216.';
                }

              },
            ),
            TextFormField(

                controller: _emailController,
                decoration: const InputDecoration(labelText: 'Email'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Veuillez saisir votre email.';
                  }
                  if (!emailRegExp.hasMatch(value)) {
                    return 'Veuillez saisir un email valide.';
                  }

                },
              ),


            TextFormField(
              controller: _passwordController,
              decoration: const InputDecoration(labelText: 'Mot de passe'),
              obscureText: true,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Veuillez saisir votre mot de passe.';
                }
                if (!passwordRegExp.hasMatch(value)) {
                  return 'Le mot de passe doit contenir au moins une lettre majuscule, une lettre minuscule, un chiffre, un caractère spécial, et être composé d\'au moins 8 caractères.';
                }

              },
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

            TextFormField(
              controller: _adresseController,
              decoration: const InputDecoration(labelText: 'Adresse'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Veuillez saisir votre adresse';
                }

              },
            ),
            TextFormField(
              controller: _villeController,
              decoration: const InputDecoration(labelText: 'Ville'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Veuillez saisir votre ville';
                }

              },
            ),

            const SizedBox(height: 32),
            SizedBox(
              width: 157.0,
              height: 44.0,
              child:Stack(
                children: [
                  XDComposant11(
                    myText: "S'inscrire",
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
                ],
              ),
            ),
          ],
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
