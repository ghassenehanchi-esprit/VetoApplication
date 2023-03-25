import 'package:flutter/material.dart';

class NotificationIcon extends StatelessWidget {
  final int notificationCount;
  final void Function() onPressed;

  const NotificationIcon({
    Key? key,
    required this.notificationCount,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          margin: EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            children: [
              IconButton(
                onPressed: onPressed,
                icon: Icon(Icons.menu),
              ),
              SizedBox(width: 60),
              Text(
                'Mon application',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontFamily: 'GothamMedium'
                ),
              ),
            ],
          ),
        ),
        Positioned(
          right: 40, // déplacer la position de l'icône de notification
          top: 5,
          child: Container(
            padding: EdgeInsets.all(5),
            decoration: BoxDecoration(
              color: Colors.transparent,
              borderRadius: BorderRadius.circular(50),
            ),
            child: Icon(
              Icons.notifications,
              color: Colors.white,
              size: 24,
            ),
          ),
        ),
        if (notificationCount > 0)
          Positioned(
            right: 35, // déplacer la position du cercle rouge
            top: 5,
            child: Container(
              width: 10, // taille du cercle rouge
              height: 10,
              decoration: BoxDecoration(
                color: Colors.red,
                shape: BoxShape.circle,
              ),
            ),
          ),
      ],
    );
  }
}
