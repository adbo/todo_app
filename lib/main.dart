import 'package:flutter/material.dart';
import 'package:todo_app/bloc/todos_provider.dart';
import 'package:todo_app/pages/todo_add_page.dart';
import 'package:todo_app/pages/todo_list_page.dart';


void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return TodosProvider(
      child: MaterialApp(
        initialRoute: '/',
        routes: {
          '/': (context) => TodoPage(),
          '/addTodo': (context) => TodoAddPage(),
        },
      ),
    );
  }
}
