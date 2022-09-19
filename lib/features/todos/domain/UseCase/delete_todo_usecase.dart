import '../RepositoryInterface/todos_repository.dart';

class DeleteTodo {
  final TodoRepository repository;

  DeleteTodo(this.repository);

  Future<void> execute(String id) async {
    return repository.deleteTodoById(id);
  }
}
