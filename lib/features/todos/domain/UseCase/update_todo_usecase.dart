import '../RepositoryInterface/todos_repository.dart';

class UpdateTodo {
  final TodoRepository repository;

  UpdateTodo(this.repository);

  Future<void> execute(final String id, final String newTitle,
      final String newDescription, final bool newIsCompleted) async {
    return await repository.updateTodo(
        id, newTitle, newDescription, newIsCompleted);
  }
}
