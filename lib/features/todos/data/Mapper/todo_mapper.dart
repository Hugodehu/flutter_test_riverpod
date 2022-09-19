import '../../domain/Model/todo.dart';
import '../Entity/todo_entity.dart';

class TodoMapper {
  static Todo transformToModel(final TodoEntity todoEntity) {
    return Todo(
      id: todoEntity['id'],
      title: todoEntity['title'],
      description: todoEntity['description'],
      completed: todoEntity['completed'],
    );
  }

  static TodoEntity transformToEntity(final Todo todo) {
    return {
      'id': todo.id,
      'title': todo.title,
      'description': todo.description,
      'completed': todo.completed,
    };
  }

  static TodoEntity transformToNewEntity(
      final String title, final String description, final bool completed) {
    return {
      'id': null,
      'title': title,
      'description': description,
      'completed': completed,
    };
  }
}
