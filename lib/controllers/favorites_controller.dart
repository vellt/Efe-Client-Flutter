import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:uk_vocabulary_builder_flutter/model/favorite.dart';
import 'package:uk_vocabulary_builder_flutter/boxes/crud_box.dart';

class FavoritesController extends GetxController {
  final Box _observableBox = CrudBox.getBox();

  Box get observableBox => _observableBox;
  int get favoritesCount => _observableBox.length;

  addFavorite({required Favorite audio}) async {
    _observableBox.add(audio);
  }

  deleteAll() {
    _observableBox.deleteAll(_observableBox.keys);
    //update();
  }

  removeFavorite({required int index}) {
    _observableBox.deleteAt(index);
    //update();
  }
}
