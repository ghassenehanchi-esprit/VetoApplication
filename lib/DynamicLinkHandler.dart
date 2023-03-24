import 'package:flutter/material.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:vetoapplication/FirebaseService.dart';
import 'package:vetoapplication/ValidationSuccessPage.dart';

class DynamicLinkHandler extends StatefulWidget {
  final Widget child;

  DynamicLinkHandler({required this.child});

  @override
  _DynamicLinkHandlerState createState() => _DynamicLinkHandlerState();
}

class _DynamicLinkHandlerState extends State<DynamicLinkHandler> {
  void initState() {
    super.initState();
    this.initDynamicLinks();
  }

  void initDynamicLinks() async {
    final PendingDynamicLinkData? data =
    await FirebaseDynamicLinks.instance.getInitialLink();

    this.handleDynamicLink(data);

    FirebaseDynamicLinks.instance.onLink.listen(
          (PendingDynamicLinkData? dynamicLinkData) async {
        this.handleDynamicLink(dynamicLinkData);
      },
      onError: (Exception e) async {
        print('Erreur lors de la gestion du lien : ${e.toString()}');
      },
    );
  }

  void handleDynamicLink(PendingDynamicLinkData? data) async {
    final Uri? link = data?.link;

    if (link != null) {
      bool isValidLink = await FirebaseService().validateLink(link);
      if (isValidLink) {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => ValidationSuccessPage(isValidLink: true),
          ),
        );
      } else {
        // gérer le cas où le lien est invalide
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }}