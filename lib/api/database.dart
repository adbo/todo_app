import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:todo_app/models/todo.dart';

abstract class Database {
  void addTodo(Todo todo);
  void setData(Todo todo);
  void deleteData(Todo todo);
  Stream<List<Todo>> todosStream();
}

class TodoDatabase implements Database {
  static final String rootPath = 'todo';

  void addTodo(Todo todo) async {
    await Firestore.instance.collection('todo').add(todo.toMap());
  }

  void setData(Todo todo) async {
    DocumentReference reference = _getReference(todo);
    await reference.setData(todo.toMap());
  }

  void deleteData(Todo todo) async {
    DocumentReference reference = _getReference(todo);
    await reference.delete();
  }

  DocumentReference _getReference(Todo todo) {
    return Firestore.instance.collection('todo').document('${todo.documentId}');
  }

  Stream<List<Todo>> todosStream() {
    return _FirestoreStream<List<Todo>>(
      apiPath: rootPath,
      parser: FirestoreCountersParser(),
    ).stream;
  }
}

abstract class FirestoreNodeParser<T> {
  T parse(QuerySnapshot querySnapshot);
}

class FirestoreCountersParser extends FirestoreNodeParser<List<Todo>> {
  List<Todo> parse(QuerySnapshot querySnapshot) {
    var todos = querySnapshot.documents.map((documentSnapshot) {
      return Todo(
        documentId: documentSnapshot.documentID,
        title: documentSnapshot['title'],
        done: documentSnapshot['done'],
      );
    }).toList();
    return todos;
  }
}

class _FirestoreStream<T> {
  _FirestoreStream({String apiPath, FirestoreNodeParser<T> parser}) {
    CollectionReference collectionReference =
        Firestore.instance.collection(apiPath);
    Stream<QuerySnapshot> snapshots = collectionReference.snapshots();
    stream = snapshots.map((snapshot) => parser.parse(snapshot));
  }

  Stream<T> stream;
}
