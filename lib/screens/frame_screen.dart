import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:uk_vocabulary_builder_flutter/model/book.dart';
import 'package:uk_vocabulary_builder_flutter/screens/settings_screen.dart';
import 'package:uk_vocabulary_builder_flutter/utils/constants.dart';

import 'favorites_screen.dart';
import 'home_screen.dart';

class FrameScreen extends StatefulWidget {
  //late Book book;
  //FrameScreen({required this.book});
  @override
  FrameScreenState createState() => FrameScreenState();
}

class FrameScreenState extends State<FrameScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  void _onItemTapped(int index) {
    setState(() => _selectedIndex = index);
  }

  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _selectedIndex,
        children: [
          HomeScreen(),
          FavoritesScreen(),
          SettingsScreen(),
        ],
      ),
      bottomNavigationBar: SizedBox(
        height: 11.0.h,
        child: BottomNavigationBar(
          selectedItemColor: kMainDarkGrayColor,
          unselectedItemColor: Color(0xFFE8E8E8),
          backgroundColor: Colors.white,
          iconSize: 5.0.h,
          showSelectedLabels: false,
          showUnselectedLabels: false,
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.school),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.favorite),
              label: 'Favorites',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.settings),
              label: 'Settings',
            ),
          ],
        ),
      ),
    );
  }
}
