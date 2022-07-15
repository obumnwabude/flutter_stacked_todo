import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../../app/locator.dart';
import '../../models/todo.dart';
import '../../services/todos.service.dart';

class TodosScreenViewModel extends ReactiveViewModel {
  final _todosService = locator<TodosService>();
  final firstFocusNode = FocusNode();

  List<Todo> get todos => _todosService.todos;

  void changeStatus(int index) => _todosService.changeStatus(index);

  void newTodo() {
    _todosService.newTodo();
    firstFocusNode.requestFocus();
  }

  void removeTodo(int index) => _todosService.removeTodo(index);

  void updateContent(String text, int index) {
    _todosService.updateContent(text, index);
  }
  
  @override
  List<ReactiveServiceMixin> get reactiveServices => [_todosService];
}
