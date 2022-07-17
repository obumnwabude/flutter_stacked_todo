import 'dart:math';

import 'package:hive_flutter/hive_flutter.dart';
import 'package:stacked/stacked.dart';

import '../models/todo.dart';

class TodosService with ReactiveServiceMixin {
  final _todos = ReactiveValue<List<Todo>>(
    Hive.box('todos').get('todos', defaultValue: []).cast<Todo>(),
  );
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

  void _saveToHive() => Hive.box('todos').put('todos', _todos.value);

  void newTodo() {
    _todos.value.insert(0, Todo(id: _randomId()));
    _saveToHive();
    notifyListeners();
  }

  bool toggleStatus(String id) {
    final index = _todos.value.indexWhere((todo) => todo.id == id);
    if (index != -1) {
      _todos.value[index].completed = !_todos.value[index].completed;
      _saveToHive();
      notifyListeners();
      return true;
    } else {
      return false;
    }
  }

  bool removeTodo(String id) {
    final index = _todos.value.indexWhere((todo) => todo.id == id);
    if (index != -1) {
      _todos.value.removeAt(index);
      _saveToHive();
      notifyListeners();
      return true;
    } else {
      return false;
    }
  }

  bool updateTodoContent(String id, String text) {
    final index = _todos.value.indexWhere((todo) => todo.id == id);
    if (index != -1) {
      _todos.value[index].content = text;
      _saveToHive();
      return true;
    } else {
      return false;
    }
  }
}
