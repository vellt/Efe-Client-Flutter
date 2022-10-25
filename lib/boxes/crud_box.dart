import 'package:uk_vocabulary_builder_flutter/model/favorite.dart';
import 'package:hive/hive.dart';

class CrudBox {
  static const String boxName = "CRUD";

  static openBox() async => await Hive.openBox<Favorite>(boxName);

  static Box getBox() => Hive.box<Favorite>(boxName);

  static closeBox() async => await Hive.box(boxName).close();
}
