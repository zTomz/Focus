import 'package:flutter/material.dart';
import 'package:pomodoro_timer/models/todo.dart';

class TodoProvider extends ChangeNotifier {
  final List<Todo> _todos = [];

  List<Todo> get todos => _todos;
  int get lenght => _todos.length;

  void addTodo(Todo todo) {
    _todos.add(todo);

    notifyListeners();
  }

  void removeTodo(Todo todo) {
    _todos.remove(todo);

    notifyListeners();
  }

  void toggleTodo(Todo todo) {
    _todos.firstWhere((element) => element.uuid == todo.uuid).isDone =
        !todo.isDone;

    notifyListeners();
  }

  void clearTodos() {
    _todos.clear();

    notifyListeners();
  }

  void reorderTodos(int oldIndex, int newIndex) {
    if (oldIndex < newIndex) {
      newIndex -= 1;
    }

    _todos.insert(newIndex, _todos.removeAt(oldIndex));

    notifyListeners();
  }
}
