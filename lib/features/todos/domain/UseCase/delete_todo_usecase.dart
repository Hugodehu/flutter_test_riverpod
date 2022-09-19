import 'package:dartz/dartz.dart';

import '../../../../Core/error/failure.dart';
import '../RepositoryInterface/todos_repository.dart';

class DeleteTodo {
  final TodoRepository repository;

  DeleteTodo(this.repository);

  Future<void> execute(String id) async {
    return repository.deleteTodoById(id);
  }
}
