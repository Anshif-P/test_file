import 'package:get/get.dart';

class TestGextController extends GetxController {
  String name = 'anshif';
  void change(String text) {
    name = text;
    update();
  }
}
