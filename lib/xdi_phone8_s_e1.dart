import 'dart:convert';



import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:adobe_xd/gradient_xd_transform.dart';
import 'package:adobe_xd/pinned.dart';
import 'package:mysql1/mysql1.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vetoapplication/AddProfilePhotoScreen.dart';
import 'package:vetoapplication/Client.dart';
import 'package:vetoapplication/ClientDashboardScreen.dart';
import 'package:vetoapplication/ForgotPasswordPage.dart';
import 'package:vetoapplication/databasehelper.dart';
import 'package:vetoapplication/degrade.dart';
import 'package:vetoapplication/firebase_constants.dart';
import 'package:vetoapplication/medecin.dart';
import 'package:vetoapplication/signupPage.dart';
import 'package:vetoapplication/EmailVerificationScreen.dart';
import './xd_composant11.dart';

import 'package:flutter_svg/flutter_svg.dart';

import 'components/CustomButton.dart';
import 'components/CustomTextField.dart';

class XDIPhone8SE1 extends StatefulWidget {
  const XDIPhone8SE1({Key? key}) : super(key: key);

  @override
  State<XDIPhone8SE1> createState() => _AuthPageState();

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }
}
class _AuthPageState extends State<XDIPhone8SE1> {

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isMedecin = false;
  late String _idname;
  late String _table;
  late int? _id;


  int? get id => _id;

  String get idname => _idname;

  bool get isMedecin => _isMedecin;
  bool _isLoading = false;


  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final screenWidth = screenSize.width;
    final screenHeight = screenSize.height;
    bool _isLoading = false;
    final CustomTextField _emailfield=CustomTextField(
      controller: _emailController,
      icon:Icons.email ,
      hintText: 'E-mail',
        );

    final CustomTextField _passwordfield=CustomTextField(
      obscureText: true,
      controller: _passwordController,
      icon:Icons.password_rounded ,
      hintText: 'Password',
    );

  return Scaffold(
    backgroundColor: Colors.transparent,
  resizeToAvoidBottomInset: true ,

      body:
           Container(
             decoration: BoxDecoration(
               gradient: LinearGradient(
                 colors: [Color(0xFF42F1A6), Color(0xFF6f76fc)],
                 begin: Alignment.topCenter,
                 end: Alignment.bottomCenter,
               ),
             ),
             child: Center(

        child:  Stack(
          children: [
              Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
              Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: 150,
                ),
                _emailfield,

              SizedBox(
                height: 20,
              ),
                _passwordfield,
                Container(
                  child: TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => ForgotPasswordPage()),
                      );
                    },
                    child: Container(
                      margin: EdgeInsets.symmetric(horizontal: 50),
                      child: Align(
                        alignment: Alignment.bottomRight,
                        child: Text(
                          "Mot de passe oublié ?",
                          style: TextStyle(
                            color:  Colors.white,
                            fontSize: 14,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 100.0),



      CustomButton(text:"Se connecter",

    onPressed: () async {
    setState(() {
    _isLoading = true;
    });
    await auth.signInWithEmailAndPassword(email: _emailController.text.trim(), password: _passwordController.text.trim());


    final conn = await DatabaseHelper().connection;

    final result = await conn.query(
      'SELECT * FROM  medecin WHERE emailMedecin = ?',
      [_emailController.text.trim()],
    );
    if(result.isEmpty){
      _idname='idClient';
      _table='client';
      final conn = await DatabaseHelper().connection;
      final result1 = await conn.query(
          'SELECT * FROM  Client WHERE emailClient = ?',
          [_emailController.text.trim()],
      );
      _id=result1.first['idClient'];


    }
    else{
      _isMedecin=true;
      _idname='idMedecin';
      _table='medecin';
      _id=result.first['idMedecin'];
    }

    if (auth.currentUser != null) {
      // Get the user data from the database

      final conn = await DatabaseHelper().connection;
      final result2 = await conn.query(
          'SELECT * FROM ${_isMedecin ? 'medecin' : 'client'} WHERE  ${_isMedecin ? 'emailMedecin' : 'emailClient'} = ?',
          [_emailController.text.trim()],
      );

      // Check if the user has uploaded a profile photo
      if (result2.isNotEmpty) {
          final photoDeProfil = result2.first['photo_profil'];
          if (photoDeProfil == null) {
              // Navigate to the AddProfilePhotoScreen if the user has not uploaded a profile photo
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (ctx) =>
                      AddProfilePhotoScreen(isMedecin: _isMedecin,
                          idname: _idname,
                          table: _table,
                          id: _id),
                ),
              );
          }  else {
    // Otherwise, navigate to the appropriate dashboard screen
    final route = _isMedecin ? ClientDashboardScreen(id: _id,) :  ClientDashboardScreen(id: _id,);
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (ctx) => route));
    }
      }
    }
    setState(() {
    _isLoading = false;
    });
    },
    ),
    ],
    ),

   Align(
    alignment: Alignment.center,
    child:
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
              "Vous n'avez pas un compte ?",
              style: TextStyle(
                color: Colors.white,
                fontSize: 13.0,
              ),
          ),
          TextButton(
          child: Text("S'inscrire",
              style: TextStyle(
                color:  Colors.white,
                fontSize: 13,
                decoration: TextDecoration.underline,
              ),
          ),
          onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SignupPage()),
                );
          },
    ),
        ],
      ),
   ),



          ],
    ),

    ],
  ),

  ),
           ),
    );









  }
  late String _token;

 /* Future<void> changePassword(String newPassword) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    print(newPassword);
    _token = sharedPreferences.getString("token")!;
    final url =
        'https://identitytoolkit.googleapis.com/v1/accounts:update?key='+'AIzaSyC2fmKNIpKUuoiX59UC4L0RyvTXv-6oFVA'
    ;
    try {
      await http.post(
        url,
        body: json.encode(
          {
            'idToken': _token,
            'password': newPassword,
            'returnSecureToken': true,
          },
        ),
      );
    } catch (error) {
      throw error;
    }
  }
  */
}
