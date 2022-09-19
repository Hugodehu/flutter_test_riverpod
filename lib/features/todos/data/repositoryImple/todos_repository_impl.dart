import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test_riverpod/Core/Api/api_repository_impl.dart';
import 'package:flutter_test_riverpod/Core/Api/api_repository_interface.dart';
import 'package:flutter_test_riverpod/features/todos/data/Entity/todo_entity.dart';
import 'package:flutter_test_riverpod/features/todos/data/Mapper/todo_mapper.dart';
import 'package:flutter_test_riverpod/features/todos/domain/Model/todo_list.dart';
import 'package:flutter_test_riverpod/features/todos/domain/Model/todo.dart';
import 'package:flutter_test_riverpod/Core/error/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test_riverpod/features/todos/domain/RepositoryInterface/todos_repository.dart';

final todoRepositoryProvider = Provider<TodoRepository>((ref) =>
    TodosRepositoryImpl(apiRepository: ref.watch(apiRepositoryProvider)));

class TodosRepositoryImpl implements TodoRepository {
  TodosRepositoryImpl({required this.apiRepository});

  final IApiRepository apiRepository;

  @override
  Future<void> createTodo(final String title, final String description,
      final bool completed) async {
    await apiRepository.post('todos',
        TodoMapper.transformToNewEntity(title, description, completed));
  }

  @override
  Future<void> deleteTodoById(String id) async {
    await apiRepository.delete('todos/$id');
  }

  @override
  Future<Todo> getTodoById(int id) async {
    final Todo todo = TodoMapper.transformToModel(
        await apiRepository.get('todos/$id') as TodoEntity);
    return todo;
  }

  @override
  Future<TodoList> getTodos() async {
    final items = await apiRepository.get("todos");
    final TodoList todoList = TodoList(
        todos: items.data
            .map<Todo>((e) => TodoMapper.transformToModel(e))
            .toList());
    return todoList;
  }

  @override
  Future<void> updateTodo(String id, String newTitle, String newDescription,
      bool newIsCompleted) async {
    final Todo todo = Todo(
      id: id,
      title: newTitle,
      description: newDescription,
      completed: newIsCompleted,
    );
    await apiRepository.put('todos/$id', TodoMapper.transformToEntity(todo));
  }
}
