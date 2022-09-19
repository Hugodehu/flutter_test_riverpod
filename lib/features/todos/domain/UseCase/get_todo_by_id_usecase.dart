import '../Model/todo.dart';
import '../RepositoryInterface/todos_repository.dart';

class GetTodoByid {
  final TodoRepository repository;

  GetTodoByid(this.repository);

  Future<Todo> execute(int id) async => repository.getTodoById(id);
}
