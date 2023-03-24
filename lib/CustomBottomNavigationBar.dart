import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:vetoapplication/ClientDashboardScreen.dart';

class CustomBottomNavigationBar extends StatefulWidget {
  const CustomBottomNavigationBar({Key? key}) : super(key: key);

  @override
  _CustomBottomNavigationBarState createState() => _CustomBottomNavigationBarState();
}

class _CustomBottomNavigationBarState extends State<CustomBottomNavigationBar> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            blurRadius: 20,
            color: Colors.black.withOpacity(.1),
          )
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(3.0),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 8),
            child: GNav(
              hoverColor: CupertinoColors.opaqueSeparator,
              curve: Curves.easeInOut,
              backgroundColor: CupertinoColors.white,
              color: CupertinoColors.systemGreen,
              tabMargin: const EdgeInsets.all(3.0),
              gap: 8,
              selectedIndex: _selectedIndex,
              iconSize: 16,
              onTabChange: (index) {
                setState(() {
                  _selectedIndex = index;
                });
              },
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              duration: Duration(milliseconds: 400),
              tabBorderRadius: 100,
              tabBackgroundColor: CupertinoColors.white,

              tabBorder: Border.all(
                color: CupertinoColors.systemGreen,
                width: 1.0,
              ),
              tabs: [
                GButton(
                  icon: CupertinoIcons.home,
                  iconActiveColor: CupertinoColors.white,
                  activeBorder: Border.all(
                    color: CupertinoColors.white,
                    width: 1.0,
                    style: BorderStyle.solid,
                  ),
                  backgroundColor: CupertinoColors.systemGreen,

                ),
                GButton(
                  icon: CupertinoIcons.settings_solid,
                  iconActiveColor: CupertinoColors.white,
                  activeBorder: Border.all(
                    color: CupertinoColors.white,
                    width: 2.0,
                    style: BorderStyle.solid,
                  ),
                  backgroundColor: CupertinoColors.systemGreen,

                ),
                GButton(
                  icon: CupertinoIcons.search_circle,
                  iconActiveColor: CupertinoColors.white,
                  activeBorder: Border.all(
                    color: CupertinoColors.white,
                    width: 2.0,
                    style: BorderStyle.solid,
                  ),
                  backgroundColor: CupertinoColors.systemGreen,

                ),
                GButton(
                  icon: Icons.medical_services_rounded,
                  iconActiveColor: CupertinoColors.white,
                  activeBorder: Border.all(
                    color: CupertinoColors.white,
                    width: 2.0,
                    style: BorderStyle.solid,
                  ),
                  backgroundColor: CupertinoColors.systemGreen,

                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
