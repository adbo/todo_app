import 'dart:math';

import 'package:flutter/material.dart';
import 'package:todo_app/bloc/todos_provider.dart';
import 'package:todo_app/models/todo.dart';
import 'package:todo_app/widgets/list_item_builder.dart';

class TodoPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Todo App'),
        elevation: 1.0,
      ),
      body: _buildContent(context),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => Navigator.pushNamed(context, '/addTodo'),
      ),
    );
  }
}

Widget _buildContent(BuildContext context) {
  final todosBloc = TodosProvider.of(context);

  return StreamBuilder<List<Todo>>(
      stream: todosBloc.todos,
      builder: (context, snapshot) {
        return ListItemsBuilder<Todo>(
          items: snapshot.data,
          itemBuilder: (context, todo) {
            return Dismissible(
              key: new Key(Random().nextInt(10000).toString()),
              child: ListTile(
                title: Text(todo.title),
                trailing: Checkbox(
                    value: todo.done,
                    onChanged: (bool value) {
                      todosBloc.addition.add(todo.copy(done: !todo.done));
                    }),
              ),
              onDismissed: (direction) {
                if (direction == DismissDirection.startToEnd)
                  todosBloc.addition.add(todo.copy(done: !todo.done));
                else if (direction == DismissDirection.endToStart)
                  todosBloc.deletion.add(todo);
              },
              background: Container(
                child: Icon(Icons.done),
                color: Colors.lightGreen,
                alignment: Alignment.centerLeft,
              ),
              secondaryBackground: Container(
                child: Icon(Icons.delete),
                color: Colors.redAccent,
                alignment: Alignment.centerRight,
              ),
            );
          },
        );
      }
  );
}
