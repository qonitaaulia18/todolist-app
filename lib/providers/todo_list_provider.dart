import 'package:flutter/material.dart';

import '../models/todo_model.dart';

class TodoListProvider with ChangeNotifier {
  List<TodoModel> _todoList = [];

  List<TodoModel> get todolist => _todoList;

  void addTodo(TodoModel todo) async {
    _todoList.add(todo);
    notifyListeners();
  }

  void removeTodo(TodoModel todo) {
    _todoList = _todoList.where((item) => item.id != todo.id).toList();
    notifyListeners();
  }

  void updateTodo(TodoModel todo) {
    _todoList[_todoList.indexWhere((item) => item.id == todo.id)] = todo;
    notifyListeners();
  }
}
