import 'package:flutter/widgets.dart';
import 'package:todo_app/api/database.dart';
import 'package:todo_app/bloc/todos_bloc.dart';

class TodosProvider extends InheritedWidget {
  final TodosBloc todosBloc;

  TodosProvider({
    Key key,
    TodosBloc todosBloc,
    Widget child,
  })  : todosBloc = todosBloc ?? TodosBloc(database: TodoDatabase()),
        super(key: key, child: child);

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) => true;

  static TodosBloc of(BuildContext context) =>
      (context.inheritFromWidgetOfExactType(TodosProvider) as TodosProvider)
          .todosBloc;
}
