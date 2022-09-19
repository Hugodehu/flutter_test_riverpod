import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test_riverpod/features/todos/domain/UseCase/get_todos_usecase.dart';

import '../data/repositoryImple/todos_repository_impl.dart';
import 'UseCase/create_todo_usecase.dart';
import 'UseCase/delete_todo_usecase.dart';
import 'UseCase/get_todo_by_id_usecase.dart';
import 'UseCase/update_todo_usecase.dart';

final getTodoListUseCaseProvider = Provider<GetTodos>((ref) {
  return GetTodos(ref.watch(todoRepositoryProvider));
});
final createTodoUseCaseProvider = Provider<CreateTodo>((ref) {
  return CreateTodo(ref.watch(todoRepositoryProvider));
});
final deleteTodoUseCaseProvider = Provider<DeleteTodo>((ref) {
  return DeleteTodo(ref.watch(todoRepositoryProvider));
});
final updateTodoUseCaseProvider = Provider<UpdateTodo>((ref) {
  return UpdateTodo(ref.watch(todoRepositoryProvider));
});
final getTodoByIdUseCaseProvider = Provider<GetTodoByid>((ref) {
  return GetTodoByid(ref.watch(todoRepositoryProvider));
});
