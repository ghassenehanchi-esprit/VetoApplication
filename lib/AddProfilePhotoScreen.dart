import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:vetoapplication/databasehelper.dart';
import 'package:vetoapplication/firebase_constants.dart';
import 'package:vetoapplication/xdi_phone8_s_e1.dart';

class AddProfilePhotoScreen extends StatefulWidget {
  final bool isMedecin;
  final String table;
  final String idname;
  final int? id;

  const AddProfilePhotoScreen({Key? key, required this.isMedecin, required this.table, required this.idname, required this.id}) : super(key: key);

  @override
  _AddProfilePhotoScreenState createState() => _AddProfilePhotoScreenState();
}

class _AddProfilePhotoScreenState extends State<AddProfilePhotoScreen> {
  late File? _imageFile = null;
  final _picker = ImagePicker();

  Future<void> _getImageFromCamera() async {
    final pickedFile = await _picker.pickImage(
      source: ImageSource.camera,
      imageQuality: 50,
    );

    setState(() {
      if (pickedFile != null) {
        _imageFile = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

  Future<void> _getImageFromGallery() async {
    final pickedFile = await _picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 50,
    );

    setState(() {
      if (pickedFile != null) {
        _imageFile = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Profile Photo'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            CircleAvatar(
              radius: 80,
              backgroundColor: Colors.grey,
              backgroundImage: _imageFile != null ? FileImage(_imageFile!) : null,
            ),
            const SizedBox(height: 20),
            ElevatedButton.icon(
              onPressed: _getImageFromCamera,
              icon: const Icon(Icons.camera_alt),
              label: const Text('Take a Photo'),
            ),
            const SizedBox(height: 20),
            ElevatedButton.icon(
              onPressed: _getImageFromGallery,
              icon: const Icon(Icons.image),
              label: const Text('Choose from Gallery'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _imageFile != null ? () async {
                // Save the image to database or storage
                final bytes = await _imageFile!.readAsBytes();
// Update the photo_de_profil column in the database
                DatabaseHelper().updateProfilePhoto(
                  widget.table,
                  bytes,
                  widget.idname,
                  widget.id,
                );

                // Navigate to the appropriate dashboard screen
               // final route = widget.isMedecin ? const MedecinDashboardScreen() : const ClientDashboardScreen();
              //  Navigator.pushReplacement(context, MaterialPageRoute(builder: (ctx) => route));
              } : null,
              child: const Text('Save'),
            ),
          ],
        ),
      ),
    );
  }
}
