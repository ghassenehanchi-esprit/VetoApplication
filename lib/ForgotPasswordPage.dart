import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:email_auth/email_auth.dart';
import 'package:vetoapplication/firebase_constants.dart';
import 'package:vetoapplication/xd_composant11.dart';
import 'package:vetoapplication/xdi_phone8_s_e1.dart';
import 'package:adobe_xd/gradient_xd_transform.dart';

class ForgotPasswordPage extends StatefulWidget {
  @override
  _ForgotPasswordPageState createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  bool _isLoading = false;
  final TextField _emailfield=TextField(
    style: TextStyle(color: Colors.white),
    decoration: InputDecoration(
      hintText: 'E-mail',
      filled: false,
      alignLabelWithHint: true,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide.none,
      ),prefixIcon: Icon(Icons.email),

    ),



  );

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
                  'Récuperer votre mot de passe',
                  style: TextStyle(
                    fontSize: 35,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 100),
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

                SizedBox(height: 20),

    SizedBox(
    width: 157.0,
    height: 44.0,
    child:
   Stack(
    children: [

    XDComposant11(myText: "Envoyer",
                  onPressed: _submit,

                ),
    ],
   ),
    ),
              ],
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



