import 'package:hive_flutter/adapters.dart';

part 'favorite.g.dart';

@HiveType(typeId: 0)
class Favorite extends HiveObject {
  @HiveField(0)
  late final int audioIndex;

  @HiveField(1)
  late final int lessonIndex;

  @HiveField(2)
  late final int bookIndex;

  Favorite({
    required this.audioIndex,
    required this.lessonIndex,
    required this.bookIndex,
  });
}
