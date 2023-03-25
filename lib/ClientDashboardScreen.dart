import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:mysql1/mysql1.dart';
import 'package:vetoapplication/CustomBottomNavigationBar.dart';
import 'package:vetoapplication/components/buttondeg.dart';
import 'package:vetoapplication/clientService.dart';
import 'package:vetoapplication/degrade.dart';
import 'package:vetoapplication/prendreRendezVous.dart';
class ClientDashboardScreen extends StatefulWidget {
  final int? id;

  const ClientDashboardScreen({Key? key, this.id}) : super(key: key);


  @override
  State<ClientDashboardScreen> createState() => _ClientDashboardScreenState();
}

class _ClientDashboardScreenState extends State<ClientDashboardScreen> {
 late MemoryImage? _profileImage;
 Future<void> _loadImage() async {
   final results = await ClientService().getImageClient(widget.id);
   if (results.isNotEmpty) {
     final blob = results.first['photo_profil'] as Blob;
     final bytes=blob.toBytes();
     if (bytes != null) {

       final uint8List = Uint8List.fromList(bytes);
       setState(() {
         _profileImage = MemoryImage(uint8List);
       });
     }
   }
 }



 @override
 void initState() {
   super.initState();
   _loadImage();
 }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          degrade(),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Container(
              child: Center(
                child: Column(
                  children: [
                SizedBox(
                  height: 20,
                ),
                      Row(

                        children: [
                          SizedBox(width: 20),

                          if (_profileImage != null)
                            CircleAvatar(
                              radius:   40,
                              backgroundImage: _profileImage!,
                            ),
                          SizedBox(width: 30),
                          Text(
                            'Bonjour,\nMonsieur',
                            style: TextStyle(
                              fontSize: 20,
                              fontFamily: "GothamMedium",
                              color: Colors.white,
                            ),
                            textAlign: TextAlign.left,
                          ),
                        ],
                      ),
                  Column(
                    children: [
                      SizedBox(
                        height: 150,
                      ),


                         Text(
                          'Vous rencontrez des problèmes sanitaires ?',
                          style: TextStyle(
                            color: Colors.white,
                            fontFamily: "GothamMedium",
                            fontSize: 25,
                            fontWeight: FontWeight.normal,
                          ),
                          textAlign: TextAlign.center,

                        ),
                      Text(
                        'Application vous rend service !',
                        style: TextStyle(
                          color: Colors.white,
                          fontFamily: "GothamLight",
                          fontSize: 25,
                          fontWeight: FontWeight.normal,
                        ),
                        textAlign: TextAlign.center,

                      ),

                      SizedBox(
                        height: 100,
                      ),
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: buttondeg(
                          onPressed: (){
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => RendezVous()),
                            );
                          },
                          myText: 'Pendre un rendez-vous',
                        ),
                      ),
                    ],
                  )

                  ],
                ),
              ),
            ),

          ),
        ],
      ),

      bottomNavigationBar: CustomBottomNavigationBar(),

    );
  }
}

