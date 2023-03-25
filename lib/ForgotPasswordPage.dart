import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:email_auth/email_auth.dart';
import 'package:vetoapplication/firebase_constants.dart';
import 'package:vetoapplication/xd_composant11.dart';
import 'package:vetoapplication/xdi_phone8_s_e1.dart';
import 'package:adobe_xd/gradient_xd_transform.dart';

import 'components/CustomButton.dart';
import 'components/CustomTextField.dart';

class ForgotPasswordPage extends StatefulWidget {

  @override
  _ForgotPasswordPageState createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final TextEditingController _emailController = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;


  @override
  Widget build(BuildContext context) {
    final CustomTextField _emailfield=CustomTextField(
      controller: _emailController,
      icon:Icons.email ,
      hintText: 'E-mail',
    );
    return Scaffold(
      backgroundColor: Colors.transparent,

      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF42F1A6), Color(0xFF6f76fc)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child:  Center(
          child: Column(

            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
                  children: [
                    const SizedBox(height: 40),

                    GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: const Icon(Icons.close),
                    ),
                    const SizedBox(height: 70),
                    Container(
                      margin: EdgeInsets.fromLTRB(50, 0, 0, 0),
                      child: const Text(
                        'Récuperer votre mot de passe',
                        style: TextStyle(
                          fontSize: 40,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    const SizedBox(height: 130),

                      _emailfield,


                    SizedBox(height: 30),



      CustomButton(text: "Envoyer",
                      onPressed: _submit,

                    ),

                  ],
                ),
        ),
            ),



    );
  }


  Future<void> _submit() async {
    setState(() {
      _isLoading = true;
    });

    try {
      final auth = FirebaseAuth.instance;
      final user = await auth.fetchSignInMethodsForEmail( _emailController.text,
      );
      if (user.isNotEmpty) {
        // Send password reset link to the user's email
        await auth.sendPasswordResetEmail(email: _emailController.text);

        // Show a snackbar message with a confirmation
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Le lien de réinitialisation du mot de passe a été envoyé à votre adresse e-mail.'),
        ));

        // Wait for 3 seconds and navigate to authentication page
        Future.delayed(Duration(seconds: 3), () {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => XDIPhone8SE1(),
            ),
          );
        });
      }

      else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Cet utilisateur n\'existe pas'),
        ));
        setState(() {
          _isLoading = false;
        });
      }
    } catch (e) {
      print(e);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Erreur: ${e.toString()}'),
      ));
      setState(() {
        _isLoading = false;
      });
    }
  }


}



