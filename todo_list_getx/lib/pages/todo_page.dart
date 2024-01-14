import 'package:d_input/d_input.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_list_getx/controllers/todo_controller.dart';
import 'package:todo_list_getx/models/todo.dart';

class TodoPage extends StatefulWidget {
  const TodoPage({super.key});

  @override
  State<TodoPage> createState() => _TodoPageState();
}

class _TodoPageState extends State<TodoPage> {
  final todoController = TodoController();

  @override
  void initState() {
    todoController.getTodo();
    super.initState();
  }

  @override
  void dispose() {
    Get.delete<TodoController>(force: true);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Todo'),
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => buildAddTodo(),
        child: const Icon(Icons.add),
      ),
      body: Obx(() {
        if (todoController.todos.isEmpty) {
          return const Center(child: Text('Empty'));
        }
        List<Todo> todos = todoController.todos;
        return ListView.builder(
          itemCount: todos.length,
          itemBuilder: (context, index) {
            Todo todo = todos[index];
            return ListTile(
              leading: IconButton.filledTonal(
                onPressed: () => buildUpdateTodo(todo),
                icon: const Icon(Icons.edit),
              ),
              title: Text(todo.title),
              subtitle: Text(todo.body),
              trailing: IconButton(
                onPressed: () {
                  todoController.removeTodo(todo.id);
                },
                icon: const Icon(Icons.delete),
              ),
            );
          },
        );
      }),
    );
  }

  buildAddTodo() {
    final edtTitle = TextEditingController();
    final edtBody = TextEditingController();
    showDialog(
      context: context,
      builder: (context) => SimpleDialog(
        title: const Text('Add Todo'),
        contentPadding: const EdgeInsets.all(20),
        children: [
          DInput(
            title: 'Title',
            controller: edtTitle,
          ),
          const SizedBox(height: 16),
          DInput(
            title: 'Body',
            controller: edtBody,
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () {
              todoController.addTodo(edtTitle.text, edtBody.text);
              Navigator.pop(context);
            },
            child: const Text('Save'),
          ),
        ],
      ),
    );
  }

  buildUpdateTodo(Todo oldTodo) {
    final edtTitle = TextEditingController();
    final edtBody = TextEditingController();
    edtTitle.text = oldTodo.title;
    edtBody.text = oldTodo.body;
    showDialog(
      context: context,
      builder: (context) => SimpleDialog(
        title: const Text('Update Todo'),
        contentPadding: const EdgeInsets.all(20),
        children: [
          DInput(
            title: 'Title',
            controller: edtTitle,
          ),
          const SizedBox(height: 16),
          DInput(
            title: 'Body',
            controller: edtBody,
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () {
              todoController.updateTodo(
                oldTodo.copyWith(
                  title: edtTitle.text,
                  body: edtBody.text,
                ),
              );
              Navigator.pop(context);
            },
            child: const Text('Save'),
          ),
        ],
      ),
    );
  }
}
