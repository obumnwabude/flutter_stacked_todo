import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'app/locator.dart';
import 'models/todo.adapter.dart';
import 'ui/todos_screen/todos_screen_view.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();
  Hive.registerAdapter(TodoAdapter());
  await Hive.openBox('todos');

  setupLocator();
  
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const TodosScreenView(),
      theme: ThemeData.dark(),
      title: 'Flutter Stacked Todos',
    );
  }
}
