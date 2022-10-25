import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uk_vocabulary_builder_flutter/controllers/landing_screen_controller.dart';
import 'package:uk_vocabulary_builder_flutter/model/book.dart';
import 'package:uk_vocabulary_builder_flutter/screens/favorites_screen.dart';
import 'package:uk_vocabulary_builder_flutter/screens/home_screen.dart';
import 'package:uk_vocabulary_builder_flutter/screens/settings_screen.dart';
import 'package:sizer/sizer.dart';
import 'package:uk_vocabulary_builder_flutter/utils/constants.dart';

class LandingScreen extends StatelessWidget {
  buildBottomNavigationMenu(context, landingPageController) {
    return Obx(() => SizedBox(
          height: 11.0.h,
          child: BottomNavigationBar(
            selectedItemColor: kMainDarkGrayColor,
            unselectedItemColor: Color(0xFFE8E8E8),
            backgroundColor: Colors.white,
            iconSize: 5.0.h,
            showSelectedLabels: false,
            showUnselectedLabels: false,
            onTap: (_) => landingPageController.changeTabIndex(_),
            currentIndex: landingPageController.tabIndex.value,
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
        ));
  }

  @override
  Widget build(BuildContext context) {
    final LandingScreenController landingPageController =
        Get.put(LandingScreenController());
    return Scaffold(
      body: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        Expanded(
          child: Obx(
            () => Center(
              child: IndexedStack(
                index: landingPageController.tabIndex.value,
                children: [
                  HomeScreen(),
                  FavoritesScreen(),
                  SettingsScreen(),
                ],
              ),
            ),
          ),
        ),
      ] //_pages[_selectedIndex],
          ),
      bottomNavigationBar:
          buildBottomNavigationMenu(context, landingPageController),
    );
  }
}
