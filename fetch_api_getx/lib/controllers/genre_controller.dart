import 'package:get/get.dart';

class GenreController extends GetxController {
  final _selected = 'Shooter'.obs;
  String get selected => _selected.value;
  set selected(String n) => _selected.value = n;
}
