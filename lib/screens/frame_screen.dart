import 'dart:async';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:uk_vocabulary_builder_flutter/utils/constants.dart';

import 'home_screen.dart';

class FrameScreen extends StatefulWidget {
  @override
  FrameScreenState createState() => FrameScreenState();
}

class FrameScreenState extends State<FrameScreen> {
  bool visible = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  void _onItemTapped(int index) {
    setState(() => _selectedIndex = index);
  }

  int _selectedIndex = 0;

  List<Widget> _pages = [
    HomeScreen(),
    Icon(
      Icons.camera,
      size: 150,
    ),
    Icon(
      Icons.chat,
      size: 150,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        Expanded(
          child: Center(
            child: IndexedStack(
              index: _selectedIndex,
              children: [..._pages],
            ),
          ),
        ),
      ] //_pages[_selectedIndex],
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
              label: 'Voice player',
            ),
          ],
        ),
      ),
    );
  }
}
