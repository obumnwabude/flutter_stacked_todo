import 'package:flutter/material.dart';

import 'app/locator.dart';
import 'ui/views/todos_screen_view.dart';

void main() {
  setupLocator();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: TodosScreenView(),
      title: 'Flutter Stacked Todos',
    );
  }
}
