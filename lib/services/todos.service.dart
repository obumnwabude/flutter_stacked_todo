import 'package:stacked/stacked.dart';

import '../models/todo.dart';

class TodosService with ReactiveServiceMixin {
  final _todos = ReactiveValue<List<Todo>>([]);

  List<Todo> get todos => _todos.value;

  TodosService() {
    listenToReactiveValues([_todos]);
  }

  void changeStatus(int index) {
    _todos.value[index].completed = !_todos.value[index].completed;
    notifyListeners();
  }

  void newTodo() {
    _todos.value.insert(0, Todo());
    notifyListeners();
  }
  
  void removeTodo(int index) {
    todos.removeAt(index);
    notifyListeners();
  }

  void updateContent(String text, int index) => todos[index].content = text;
}
