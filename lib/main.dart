import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:vetoapplication/DynamicLinkHandler.dart';
import 'package:vetoapplication/authentification_page.dart';
import 'package:vetoapplication/firebase_constants.dart';
import 'package:vetoapplication/xd_composant11.dart';
import 'package:vetoapplication/xdi_phone8_s_e1.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await firebaseInitialization;
  runApp(
    MaterialApp(
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: [
        const Locale('en', ''), // English, no country code
        const Locale('fr', ''), // French, no country code
      ],
      home: MediaQuery(
        data: MediaQueryData(),
        child: MyHomePage(),
      ),
    ),
  );
  Map<String, String> headers = {};
  String? locale = WidgetsBinding.instance?.window.locale.toLanguageTag();
  if (locale != null) {
    headers['X-Firebase-Locale'] = locale;}
}
class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
     return DynamicLinkHandler(child:Scaffold(

      body: Center(
        child: XDIPhone8SE1(),
      ),
     ),
    );
  }
}
