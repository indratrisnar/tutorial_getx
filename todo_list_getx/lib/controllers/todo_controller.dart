import 'package:get/get.dart';
import 'package:todo_list_getx/models/todo.dart';
import 'package:uuid/uuid.dart';

class TodoController extends GetxController {
  final RxList<Todo> _todos = <Todo>[].obs;
  List<Todo> get todos => _todos;

  getTodo() {
    print('getTodo');
    _todos.value = [
      Todo(
        id: const Uuid().v4(),
        title: 'title',
        body: 'body',
      ),
    ];
  }

  addTodo(String title, String body) {
    print('addTodo');
    Todo newTodo = Todo(
      id: const Uuid().v4(),
      title: title,
      body: body,
    );
    List<Todo> newList = [...todos, newTodo];
    _todos.value = newList;
  }

  updateTodo(Todo newTodo) {
    print('updateTodo');
    List<Todo> newList = [...todos];
    int index = todos.indexWhere((e) => e.id == newTodo.id);
    if (index < 0) return;

    newList[index] = newTodo;
    _todos.value = newList;
  }

  removeTodo(String id) {
    print('removeTodo');
    List<Todo> newList = [...todos];
    newList.removeWhere((e) => e.id == id);
    _todos.value = newList;
  }
}
