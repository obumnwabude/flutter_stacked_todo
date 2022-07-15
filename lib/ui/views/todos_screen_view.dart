import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import 'todos_screen_viewmodel.dart';

class TodosScreenView extends StatelessWidget {
  const TodosScreenView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<TodosScreenViewModel>.reactive(
      viewModelBuilder: () => TodosScreenViewModel(),
      builder: (context, model, _) => Scaffold(
        appBar: AppBar(title: const Text('Flutter Stacked Todos')),
        body: ListView(
          padding: const EdgeInsets.symmetric(vertical: 16),
          children: [
            if (model.todos.isEmpty)
              Opacity(
                opacity: 0.5,
                child: Column(
                  children: const [
                    SizedBox(height: 64),
                    Icon(Icons.emoji_food_beverage_outlined, size: 48),
                    SizedBox(height: 16),
                    Text('No todos yet. Click + to add a new one.'),
                  ],
                ),
              ),
            ...model.todos.map((todo) {
              return ListTile(
                leading: IconButton(
                  icon: Icon(
                    todo.completed ? Icons.task_alt : Icons.circle_outlined,
                  ),
                  onPressed: () => model.toggleStatus(todo.id),
                ),
                title: TextField(
                  decoration: null,
                  controller: TextEditingController(text: todo.content),
                  focusNode: model.getFocusNode(todo.id),
                  maxLines: null,
                  onChanged: (text) => model.updateTodoContent(todo.id, text),
                  style: TextStyle(
                    fontSize: 20,
                    decoration:
                        todo.completed ? TextDecoration.lineThrough : null,
                  ),
                ),
                trailing: IconButton(
                  icon: const Icon(Icons.horizontal_rule),
                  onPressed: () => model.removeTodo(todo.id),
                ),
              );
            }),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: model.newTodo,
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}
