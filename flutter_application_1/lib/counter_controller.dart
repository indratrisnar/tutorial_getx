import 'package:get/get.dart';

class CounterController extends GetxController {
  final _counter = 0.obs;
  int get counter => _counter.value;
  increment() {
    _counter.value++;
    update();
  }

  decrement() {
    _counter.value--;
    update();
  }
}
