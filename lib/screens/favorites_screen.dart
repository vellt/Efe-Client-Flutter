import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uk_vocabulary_builder_flutter/controllers/favorites_controller.dart';
import 'package:uk_vocabulary_builder_flutter/model/favorite.dart';

class FavoritesScreen extends StatelessWidget {
  FavoritesScreen({Key? key}) : super(key: key);
  final controller = Get.put(FavoritesController());

  @override
  Widget build(BuildContext context) {
    /*controller.addFavorite(
      audio: Favorite(
        bookIndex: 13,
        lessonIndex: 0,
        audioIndex: 0,
      ),
    );
    print("fav.count: ${controller.favoritesCount}");*/
    return Scaffold(
      body: Center(
        child: Text("Favorites"),
      ),
    );
  }
}
