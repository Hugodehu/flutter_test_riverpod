import 'package:dartz/dartz.dart';
import 'package:flutter_test_riverpod/features/todos/domain/Model/todo_list.dart';

import '../../../../Core/error/failure.dart';
import '../Model/todo.dart';

abstract class TodoRepository {
  Future<TodoList> getTodos();
  Future<Todo> getTodoById(int id);
  Future<void> createTodo(
    final String newTitle,
    final String newDescription,
    final bool newIsCompleted,
  );
  Future<void> updateTodo(
    final String id,
    final String newTitle,
    final String newDescription,
    final bool newIsCompleted,
  );
  Future<void> deleteTodoById(String id);
}

// import 'package:dartz/dartz.dart';
// import 'package:flutter_test_riverpod/features/todos/domain/Model/todo_list.dart';

// import '../../../../Core/error/failure.dart';
// import '../Model/todo.dart';

// abstract class TodoRepository {
//   Future<TodoList> getTodos();
//   Future<Either<Failure, Todo>> getTodoById(int id);
//   Future<Either<Failure, Todo>> createTodo(Todo todo);
//   Future<Either<Failure, Todo>> updateTodo(Todo todo);
//   Future<Either<Failure, Todo>> deleteTodoById(int id);
// }
