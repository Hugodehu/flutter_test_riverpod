import 'package:dartz/dartz.dart';

import '../../../../Core/error/failure.dart';
import '../Model/todo.dart';
import '../RepositoryInterface/todos_repository.dart';

class CreateTodo {
  final TodoRepository repository;

  CreateTodo(this.repository);

  Future<void> execute(
    final String newTitle,
    final String newDescription,
    final bool newIsCompleted,
  ) async {
    return await repository.createTodo(
      newTitle,
      newDescription,
      newIsCompleted,
    );
  }
}
