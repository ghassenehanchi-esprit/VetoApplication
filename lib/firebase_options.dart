// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
/// import 'firebase_options.dart';
/// // ...
/// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );
/// ```
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        return macos;
      case TargetPlatform.windows:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for windows - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyCHcleA3R7oN0bUDAzc7RKqvpRzbbFTZVw',
    appId: '1:791662008583:web:3f2c0528d1778064440da2',
    messagingSenderId: '791662008583',
    projectId: 'medecin-772dc',
    authDomain: 'medecin-772dc.firebaseapp.com',
    databaseURL: 'https://medecin-772dc-default-rtdb.europe-west1.firebasedatabase.app',
    storageBucket: 'medecin-772dc.appspot.com',
    measurementId: 'G-5R9BSZ5WNR',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyC2fmKNIpKUuoiX59UC4L0RyvTXv-6oFVA',
    appId: '1:791662008583:android:1c45723f7251b702440da2',
    messagingSenderId: '791662008583',
    projectId: 'medecin-772dc',
    databaseURL: 'https://medecin-772dc-default-rtdb.europe-west1.firebasedatabase.app',
    storageBucket: 'medecin-772dc.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBhZ10f7oEw2c5o2IqWOV5aT0G94J68FjA',
    appId: '1:791662008583:ios:a751ba93e2170879440da2',
    messagingSenderId: '791662008583',
    projectId: 'medecin-772dc',
    databaseURL: 'https://medecin-772dc-default-rtdb.europe-west1.firebasedatabase.app',
    storageBucket: 'medecin-772dc.appspot.com',
    iosClientId: '791662008583-i0p35n7k6qfjg666shqbib3nv3bcs69l.apps.googleusercontent.com',
    iosBundleId: 'com.example.vetoapplication',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyBhZ10f7oEw2c5o2IqWOV5aT0G94J68FjA',
    appId: '1:791662008583:ios:a751ba93e2170879440da2',
    messagingSenderId: '791662008583',
    projectId: 'medecin-772dc',
    databaseURL: 'https://medecin-772dc-default-rtdb.europe-west1.firebasedatabase.app',
    storageBucket: 'medecin-772dc.appspot.com',
    iosClientId: '791662008583-i0p35n7k6qfjg666shqbib3nv3bcs69l.apps.googleusercontent.com',
    iosBundleId: 'com.example.vetoapplication',
  );
}
