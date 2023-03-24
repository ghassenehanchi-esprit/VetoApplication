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
    final TextField _emailfield=TextField(
      controller: _emailController,
      style: TextStyle(color: Colors.white),
      decoration: InputDecoration(
        hintText: 'E-mail',
        filled: false,
        alignLabelWithHint: true,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide.none,
        ),
      ),);
    final TextField _passwordfield=TextField(
      controller: _passwordController,obscureText: true,
      style: TextStyle(color: Colors.white),
      decoration: InputDecoration(
        hintText: 'Mot de passe',
        filled: false,
        alignLabelWithHint: true,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide.none,
        ),
      ),);

  return Scaffold(
      backgroundColor: Colors.white70,

  resizeToAvoidBottomInset: true ,

      body:
           Center(
        child:  Stack(
          children: [degrade(),
            Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
            Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [

              Container(
                width: 300,
                height: 40,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  gradient: LinearGradient(
                    colors: [Color(0xFF42F1A6), Color(0xFF6F76FC)],
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                  ),
                  border: Border.all(
                    width: 2,
                    style: BorderStyle.solid,
                    color: Colors.greenAccent,
                  ),
                ),
                child: _emailfield,
              ),




              const SizedBox(height: 20.0),
              Container(
                width: 300,
                height: 40,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  gradient: LinearGradient(
                    colors: [Color(0xFF42F1A6), Color(0xFF6F76FC)],
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                  ),
                  border: Border.all(
                    width: 2,
                    style: BorderStyle.solid,
                    color: Colors.greenAccent,
                  ),
                ),
                child: _passwordfield,
              ),




              SizedBox(height: 40.0),


              SizedBox(
    width: 157.0,
    height: 44.0,
    child:Stack(
    children: [

    XDComposant11(myText: "Se connecter",

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
    )

    ),
],),




    Container(
    child: TextButton(
    onPressed: () {
      Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => ForgotPasswordPage()),
      );
    },
    child: Text(
    "Mot de passe oublié ?",
    style: TextStyle(
    color: Colors.black,
    fontSize: 16,
    decoration: TextDecoration.underline,
    ),
    ),
    ),
    ),

   Align(
    alignment: Alignment.center,
    child: Column(

    children: <Widget>[
    Text(
    "Vous n'avez pas un compte ?",
    style: TextStyle(
    color: Colors.grey[600],
    fontSize: 16.0,
    ),
    ),
    SizedBox(height: 10.0),
    SizedBox(
    width: 157.0,
    height: 44.0,
    child:Stack(
    children: [
      XDComposant11(
      myText: "S'inscrire",
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
              ),


          ],
    ),
           ],),
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
