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
            ...model.todos.asMap().entries.map((entry) {
              return ListTile(
                leading: IconButton(
                  icon: Icon(
                    entry.value.completed
                        ? Icons.task_alt
                        : Icons.radio_button_unchecked_outlined,
                  ),
                  onPressed: () => model.changeStatus(entry.key),
                ),
                title: TextField(
                  decoration: null,
                  controller: TextEditingController(text: entry.value.content),
                  focusNode: entry.key == 0 ? model.firstFocusNode : null,
                  maxLines: null,
                  onChanged: (text) => model.updateContent(text, entry.key),
                  style: TextStyle(
                    fontSize: 20,
                    decoration: entry.value.completed
                        ? TextDecoration.lineThrough
                        : null,
                  ),
                ),
                trailing: IconButton(
                  icon: const Icon(Icons.horizontal_rule_outlined),
                  onPressed: () => model.removeTodo(entry.key),
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
