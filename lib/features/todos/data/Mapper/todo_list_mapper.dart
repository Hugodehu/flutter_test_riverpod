import 'package:flutter_test_riverpod/features/todos/data/Entity/todo_entity.dart';
import 'package:flutter_test_riverpod/features/todos/data/Mapper/todo_mapper.dart';
import 'package:flutter_test_riverpod/features/todos/domain/Model/todo_list.dart';

class TodoListMapper {
  static TodoList transformToModel(final TodoListEntity todoList) {
    final values =
        todoList.map((entity) => TodoMapper.transformToModel(entity)).toList();
    return TodoList(todos: values);
  }

  static TodoListEntity transformToEntity(final TodoList todoList) =>
      todoList.todos.map((todo) => TodoMapper.transformToEntity(todo)).toList();
}
