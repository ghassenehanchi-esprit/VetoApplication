import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseService {
  static late FirebaseApp _firebaseApp;
  static late FirebaseAuth _firebaseAuth;

  static Future<void> initialize() async {
    _firebaseApp = await Firebase.initializeApp();
    _firebaseAuth = FirebaseAuth.instance;
  }
  Future<bool> validateLink(Uri link) async {
    if (link.queryParameters.containsKey('email') &&
        link.queryParameters.containsKey('token') &&
        link.queryParameters.containsKey('hash')) {
      final String email = link.queryParameters['email']!;
      final String token = link.queryParameters['token']!;
      final String hash = link.queryParameters['hash']!;
      final ActionCodeSettings actionCodeSettings = ActionCodeSettings(
        url: link.toString(),
        handleCodeInApp: true,
      );
      try {
        await FirebaseAuth.instance
            .checkActionCode(hash)
            .then((value) async {
          await FirebaseAuth.instance.applyActionCode(hash);
        });
        await FirebaseAuth.instance.signInWithEmailLink(
            email: email, emailLink: link.toString());
        final User? user = FirebaseAuth.instance.currentUser;
        if (user != null) {
          await user.reload();
          if (user.emailVerified) {
            return true;
          }
        }
      } on FirebaseAuthException catch (e) {
        print('Erreur lors de la validation du lien : ${e.toString()}');
      }
    }
    return false;
  }
  static FirebaseApp get firebaseApp => _firebaseApp;
  static FirebaseAuth get firebaseAuth => _firebaseAuth;
}

