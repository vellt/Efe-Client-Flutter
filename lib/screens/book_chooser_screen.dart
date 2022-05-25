import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:uk_vocabulary_builder_flutter/controllers/api_books_controller.dart';
import 'package:uk_vocabulary_builder_flutter/screens/frame_screen.dart';
import 'package:uk_vocabulary_builder_flutter/utils/constants.dart';
import 'package:get/get.dart';

class BookChooser extends StatelessWidget {
  BookChooser({Key? key}) : super(key: key);
  ApiBooksController apiBooksController = ApiBooksController();

  Widget _buildRow(int index) {
    return TextButton(
      style: TextButton.styleFrom(primary: Color(0xFFADADAD)),
      onPressed: () {
        apiBooksController.selectedIndex.value = index;
      },
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 4.2.w, vertical: 1.w),
        child: Obx(
          () => ListTile(
            title: Text(
              apiBooksController.books[index].title,
              style: TextStyle(
                fontSize: 14.sp,
                color: Color(0xFF514D4D),
                fontWeight: (apiBooksController.selectedIndex.value == index)
                    ? FontWeight.w700
                    : null,
              ),
            ),
            trailing: (apiBooksController.selectedIndex.value == index)
                ? Icon(
                    Icons.check,
                    color: Color(0xFF514D4D),
                    size: 18.sp,
                  )
                : null,
          ),
        ),
      ),
    );
  }

  PreferredSize bottomAppBar() {
    return PreferredSize(
      preferredSize: Size.fromHeight(10.h),
      child: Padding(
        padding: EdgeInsets.only(left: 10.w, right: 15.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Choose your book",
              textAlign: TextAlign.left,
              style: kHomeTitleTextStyle,
            ),
            SizedBox(
              height: 3.h,
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: apiBooksController.onInit(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            //inicializálás befejeződött
            if (apiBooksController.books.length == 0) {
              //nem sikerült adatot betölteni
              return Container(); //error
            } else {
              //sikerült adatot betölteni
              return Scaffold(
                appBar: AppBar(
                  bottom: bottomAppBar(),
                ),
                body: ListView.separated(
                  itemCount: apiBooksController.books.length,
                  padding: EdgeInsets.only(top: 0.5.h),
                  separatorBuilder: (BuildContext context, int index) =>
                      Divider(
                    height: 0.01.sp,
                  ),
                  itemBuilder: (BuildContext context, int index) {
                    return _buildRow(index);
                  },
                ),
                floatingActionButton: Padding(
                  padding: EdgeInsets.only(right: 10.sp, bottom: 10.sp),
                  child: FloatingActionButton(
                    child: Icon(CupertinoIcons
                        .chevron_forward), //Icons.navigate_next //Icons.save
                    onPressed: () {
                      print(apiBooksController.selectedBook.title);
                      Get.to(FrameScreen(
                        book: apiBooksController.selectedBook,
                      ));
                    },
                    backgroundColor: Color(0xFF707070),
                  ),
                ),
              );
            }
          } else {
            return Scaffold(
              appBar: AppBar(
                bottom: bottomAppBar(),
              ),
              backgroundColor: Colors.white,
              body: Center(
                child: CircularProgressIndicator(
                  color: kMainDarkGrayColor,
                ),
              ),
            );
          }
        });
  }
}
