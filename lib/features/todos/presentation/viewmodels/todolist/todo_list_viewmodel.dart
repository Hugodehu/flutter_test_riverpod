import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test_riverpod/features/todos/domain/UseCase/create_todo_usecase.dart';
import 'package:flutter_test_riverpod/features/todos/domain/UseCase/delete_todo_usecase.dart';
import 'package:flutter_test_riverpod/features/todos/domain/UseCase/get_todo_by_id_usecase.dart';
import 'package:flutter_test_riverpod/features/todos/domain/UseCase/get_todos_usecase.dart';
import 'package:flutter_test_riverpod/features/todos/domain/UseCase/update_todo_usecase.dart';

import '../../../domain/Model/todo.dart';
import '../../../domain/Model/todo_list.dart';
import '../../../domain/domain_module.dart';
import '../../State/state.dart';

final todoListViewModelProvider =
    StateNotifierProvider.autoDispose<TodoListViewModel, TodoState>((ref) {
  return TodoListViewModel(
    ref.watch(createTodoUseCaseProvider),
    ref.watch(deleteTodoUseCaseProvider),
    ref.watch(getTodoByIdUseCaseProvider),
    ref.watch(getTodoListUseCaseProvider),
    ref.watch(updateTodoUseCaseProvider),
  );
});

enum TodoStatus { initial, success, error, loading }

extension TodoStatusX on TodoStatus {
  bool get isInitial => this == TodoStatus.initial;
  bool get isSuccess => this == TodoStatus.success;
  bool get isError => this == TodoStatus.error;
  bool get isLoading => this == TodoStatus.loading;
}

class TodoState {
  TodoState({this.status = TodoStatus.initial, this.todos});

  TodoStatus status;
  TodoList? todos;

  TodoState copyWith({TodoStatus? status, TodoList? todos}) {
    return TodoState(
      status: status ?? this.status,
      todos: todos ?? this.todos,
    );
  }
}

class TodoListViewModel extends StateNotifier<TodoState> {
  final CreateTodo _createTodo;
  final DeleteTodo _deleteTodo;
  final GetTodoByid _getTodoByid;
  final GetTodos _getTodoListUseCase;
  final UpdateTodo _updateTodo;

  TodoListViewModel(this._createTodo, this._deleteTodo, this._getTodoByid,
      this._getTodoListUseCase, this._updateTodo)
      : super(TodoState()) {
    getTodoList();
  }

  getTodoList() async {
    state = state.copyWith(status: TodoStatus.loading);
    final todosList = await _getTodoListUseCase.execute();
    state = state.copyWith(status: TodoStatus.success, todos: todosList);
  }

  createTodo(final String title, final String description,
      final bool completed) async {
    state = state.copyWith(status: TodoStatus.loading);
    await _createTodo.execute(title, description, completed);
    getTodoList();
  }

  deleteTodo(String id) async {
    state = state.copyWith(status: TodoStatus.loading);
    await _deleteTodo.execute(id);
    TodoList todos = state.todos!;
    todos = todos.removeTodo(id);
    state = state.copyWith(status: TodoStatus.success, todos: todos);
  }

  getTodoById(int id) async {
    state = state.copyWith(status: TodoStatus.loading);
    await _getTodoByid.execute(id);
    state = state.copyWith(status: TodoStatus.success);
  }

  updateTodo(
      String id, String title, String description, bool completed) async {
    state = state.copyWith(status: TodoStatus.loading);
    await _updateTodo.execute(id, title, description, completed);
    TodoList todos = state.todos!;
    todos = todos.updateTodo(Todo(
        id: id, title: title, description: description, completed: completed));
    state = state.copyWith(status: TodoStatus.success, todos: todos);
  }

  completeTodo(final Todo todo) {
    final newtodo = todo.copyWith(completed: true);
    updateTodo(
        newtodo.id, newtodo.title, newtodo.description, newtodo.completed);
  }

  uncompleteTodo(final Todo todo) {
    final newtodo = todo.copyWith(completed: false);
    updateTodo(
        newtodo.id, newtodo.title, newtodo.description, newtodo.completed);
  }
}
