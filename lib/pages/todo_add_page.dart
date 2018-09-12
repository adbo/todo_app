import 'package:flutter/material.dart';
import 'package:todo_app/bloc/todos_provider.dart';
import 'package:todo_app/models/todo.dart';

class TodoAddPage extends StatefulWidget {
  @override
  FormTodoAdd createState() {
    return FormTodoAdd();
  }
}

class FormTodoAdd extends State<TodoAddPage> {
  final _formKey = GlobalKey<FormState>();
  String _title;
  DateTime _dueDate;
  Todo _todo;

  @override
  Widget build(BuildContext context) {
    final todosBloc = TodosProvider.of(context);

    return StreamBuilder<List<Todo>>(
      stream: todosBloc.todos,
      builder: (context, snapshot) {
        return Scaffold(
          appBar: AppBar(
            title: Text("Add new item"),
          ),
          body: Form(
            key: _formKey,
            child: ListView(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              children: <Widget>[
                SizedBox(height: 20.0),
                TextFormField(
                  decoration: InputDecoration(
                    filled: true,
                    labelText: "Todo name",
                  ),
                  validator: (value) {
                    if (value.isEmpty) {
                      return "Please enter name";
                    }
                  },
                  onSaved: (value) {
                    this._title = value;
                  },
                ),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: "Due date",
                    icon: Icon(Icons.date_range),
                  ),
                  keyboardType: TextInputType.datetime,
                ),
                ButtonBar(
                  children: <Widget>[
                    FlatButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text("CANCEL"),
                    ),
                    RaisedButton(
                      color: Colors.lightGreenAccent,
                      onPressed: () {
                        if (_formKey.currentState.validate()) {
                          _formKey.currentState.save();
                          _todo = Todo(title: _title, done: false);
                          todosBloc.addition.add(_todo);
                          Navigator.pop(context);
                        }
                      },
                      child: Text("ADD"),
                    ),
                  ],
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
