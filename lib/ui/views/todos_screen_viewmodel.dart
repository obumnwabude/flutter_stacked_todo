import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../../app/locator.dart';
import '../../models/todo.dart';
import '../../services/todos.service.dart';

class TodosScreenViewModel extends ReactiveViewModel {
  final _todosService = locator<TodosService>();
  late final toggleStatus = _todosService.toggleStatus;
  final _firstTodoFocusNode = FocusNode();
  late final removeTodo = _todosService.removeTodo;
  late final updateTodoContent = _todosService.updateTodoContent;

  List<Todo> get todos => _todosService.todos;

  void newTodo() {
    _todosService.newTodo();
    _firstTodoFocusNode.requestFocus();
  }

  FocusNode? getFocusNode(String id) {
    final index = todos.indexWhere((todo) => todo.id == id);
    return index == 0 ? _firstTodoFocusNode : null;
  }

  @override
  List<ReactiveServiceMixin> get reactiveServices => [_todosService];
}
