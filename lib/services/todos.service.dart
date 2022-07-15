import 'dart:math';

import 'package:stacked/stacked.dart';

import '../models/todo.dart';

class TodosService with ReactiveServiceMixin {
  final _todos = ReactiveValue<List<Todo>>([]);
  final _random = Random();

  List<Todo> get todos => _todos.value;

  TodosService() {
    listenToReactiveValues([_todos]);
  }

  String _randomId() {
    return String.fromCharCodes(
      List.generate(10, (_) => _random.nextInt(33) + 80),
    );
  }

  bool toggleStatus(String id) {
    final index = _todos.value.indexWhere((todo) => todo.id == id);
    if (index != -1) {
      todos[index].completed = !todos[index].completed;
      notifyListeners();
      return true;
    } else {
      return false;
    }
  }

  void newTodo() {
    _todos.value.insert(0, Todo(id: _randomId()));
    notifyListeners();
  }

  bool removeTodo(String id) {
    final index = _todos.value.indexWhere((todo) => todo.id == id);
    if (index != -1) {
      _todos.value.removeAt(index);
      notifyListeners();
      return true;
    } else {
      return false;
    }
  }

  bool updateTodoContent(String id, String text) {
    final index = _todos.value.indexWhere((todo) => todo.id == id);
    if (index != -1) {
      todos[index].content = text;
      return true;
    } else {
      return false;
    }
  }
}
