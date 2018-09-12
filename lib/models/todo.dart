import 'package:meta/meta.dart';

class Todo {
  final String documentId;
  final String title;
  final bool done;
  final DateTime dueDate;

  Todo({this.documentId, @required this.title, this.done, this.dueDate});

  Map<String, dynamic> toMap() => {
    "title": title,
        "done": done,
    "dueDate": dueDate,
      };

  Todo copy({String title, bool done, DateTime dueDate}) {
    return Todo(
        documentId: this.documentId,
      title: title ?? this.title,
      done: done ?? this.done,
      dueDate: dueDate ?? this.dueDate,
    );
  }
}
