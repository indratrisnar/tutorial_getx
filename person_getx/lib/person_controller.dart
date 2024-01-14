import 'package:get/get.dart';
import 'package:person_getx/person.dart';

class PersonController extends GetxController {
  // final _data = Person('', 0).obs;
  // Person get data => _data.value;

  // updateName(String n) => _data.value = data.copyWith(name: n);
  // updateAge(int n) => _data.value = data.copyWith(age: n);

  final _name = ''.obs;
  String get name => _name.value;
  set name(String n) => _name.value = n;

  final _age = 0.obs;
  int get age => _age.value;
  set age(int n) => _age.value = n;
}
