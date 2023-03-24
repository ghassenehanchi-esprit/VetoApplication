import 'package:flutter/material.dart';
class ValidationSuccessPage extends StatelessWidget {
  final bool isValidLink;

  ValidationSuccessPage({required this.isValidLink});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Validation du compte'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              isValidLink ? Icons.check_circle : Icons.error,
              size: 100,
              color: isValidLink ? Colors.green : Colors.red,
            ),
            SizedBox(height: 20),
            Text(
              isValidLink
                  ? 'Votre compte a été validé'
                  : 'Le lien de validation est invalide',
              style: TextStyle(fontSize: 20),
            ),
          ],
        ),
      ),
    );
  }
}
