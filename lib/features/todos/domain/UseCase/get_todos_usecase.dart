import 'package:dartz/dartz.dart';
import 'package:flutter_test_riverpod/Core/error/failure.dart';
import 'package:flutter_test_riverpod/features/todos/domain/Model/todo_list.dart';

import '../RepositoryInterface/todos_repository.dart';

class GetTodos {
  final TodoRepository repository;

  GetTodos(this.repository);

  Future<TodoList> execute() async => repository.getTodos();

  // Future<Either<Failure, List<Todo>>> call() async {
  //   return await repository.getTodos();
  // }
}
