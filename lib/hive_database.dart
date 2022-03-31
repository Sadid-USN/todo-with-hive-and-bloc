import 'package:hive_flutter/adapters.dart';

import 'models/todo_model.dart';

class HiveDataBase {
  String todos = 'todos';

  Future<Box> openBox() async {
    Box box = await Hive.openBox<Todo>(todos);
    return box;
  }

  List<Todo> getTodo(Box box) {
    return box.values.toList().cast<Todo>();
  }

  Future<void> addTodo(Box box, Todo todo) async {
    await box.put(todo.id, todo);
  }

  Future<void> updateTodo(Box box, Todo todo) async {
    await box.put(todo.id, todo);
  }

  Future<void> deleteOneTodo(Box box, Todo todo) async {
    await box.delete(todo.id);
  }

  Future<void> deleteAllTodo(Box box) async {
    await box.clear();
  }
}
