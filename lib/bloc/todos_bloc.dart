import 'dart:async';

import 'package:todo_app/api/database.dart';
import 'package:todo_app/models/todo.dart';

class TodosBloc {
  final Database database;
  final _addController = StreamController<Todo>();
  final _deleteController = StreamController<Todo>();

  Sink<Todo> get addition => _addController;
  Sink<Todo> get deletion => _deleteController;
  Stream<List<Todo>> _todos = Stream.empty();
  Stream<List<Todo>> get todos => _todos;

  TodosBloc({this.database}) {
    _todos = database.todosStream();
    _addController.stream.listen((todo) {
      todo.documentId == null ? database.addTodo(todo) : database.setData(todo);
    });
    _deleteController.stream.listen((todo) {
      database.deleteData(todo);
    });
  }

  void dispose() {
    _addController.close();
    _deleteController.close();
  }
}
