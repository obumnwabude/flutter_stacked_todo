import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../../models/todo.dart';

class TodosScreenViewModel extends BaseViewModel {
  final firstFocusNode = FocusNode();
  final List<Todo> todos = [];

  void changeStatus(int index) {
    todos[index].completed = !todos[index].completed;
    notifyListeners();
  }

  void newTodo() {
    todos.insert(0, Todo());
    notifyListeners();
    firstFocusNode.requestFocus();
  }

  void removeTodo(int index) {
    todos.removeAt(index);
    notifyListeners();
  }

  void updateContent(String text, int index) => todos[index].content = text;
}
