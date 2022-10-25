import 'package:uk_vocabulary_builder_flutter/api/secret.dart' as secret;

class Book {
  late int id;
  late String title;
  late String _route;
  String get route => secret.getApiRouteOfBook(_route);

  Book({required this.id, required this.title, required String route}) {
    this._route = route;
  }
}
