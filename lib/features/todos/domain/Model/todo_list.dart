import 'package:flutter_test_riverpod/features/todos/domain/Model/todo.dart';

class TodoList {
  final List<Todo> todos;

  TodoList({
    required this.todos,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TodoList &&
          runtimeType == other.runtimeType &&
          todos == other.todos;

  @override
  int get hashCode => todos.hashCode;

  TodoList addTodo(final Todo todo) {
    return TodoList(todos: [...todos, todo]);
  }

  TodoList removeTodo(final String id) {
    return TodoList(todos: todos.where((todo) => todo.id != id).toList());
  }

  TodoList updateTodo(final Todo todo) {
    return TodoList(
        todos: todos.map((t) => t.id == todo.id ? todo : t).toList());
  }

  TodoList filterByCompleted(final bool completed) {
    return TodoList(
        todos: todos.where((todo) => todo.completed == completed).toList());
  }

  TodoList filterByInCompleted(final bool completed) {
    return TodoList(
        todos: todos.where((todo) => todo.completed != completed).toList());
  }

  TodoList getTodoById(final int id) {
    return TodoList(todos: todos.where((todo) => todo.id == id).toList());
  }
}
