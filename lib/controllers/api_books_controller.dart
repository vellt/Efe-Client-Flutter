import 'dart:async';
import 'package:get/get.dart';
import 'package:uk_vocabulary_builder_flutter/api/secret.dart' as secret;
import 'package:uk_vocabulary_builder_flutter/utils/networking.dart';
import 'package:uk_vocabulary_builder_flutter/model/book.dart';

//inicializáláskor ennek kell lennie az elsp elemnek ezután kiválasztható a
// beállyítások közül, választás után
//lekéri az adtott könyv tartalmát is,

//hive alapján előnek beolvassa mi volt utoljára megnyitva, lekéri a konyveket, madj az adott
//konyvet amit uljora megyitottunk,

//ha nem állitottuk be a beállításokban hogy mentse az utolsó pozícionkat betölti a könvyeket
//majd a könyv választót megnyitva
// választás után betölti hálózatról az adott könyvet.
class ApiBooksController extends GetxController {
  Rx<int> selectedIndex = 0.obs;
  Book get selectedBook => books[selectedIndex.value];
  final List<Book> books = [];

  @override
  Future onInit() async {
    super.onInit();
    NetworkHelper networkHelper = NetworkHelper(Uri.parse(secret.apiBooksUrl));
    var data = await networkHelper.getData();
    if (data != null) {
      for (var dataItem in data) {
        int index = dataItem['data']['index'];
        String route = dataItem['data']['route'];
        String title = dataItem['data']['title'];
        books.add(Book(
          id: index,
          title: title,
          route: route,
        ));
      }
    }

    ever(
      selectedIndex,
      (_) => print(
          "$_ has been changed: ${selectedBook.title}\n${selectedBook.route} ${selectedBook.id}"),
    );
  }
}
