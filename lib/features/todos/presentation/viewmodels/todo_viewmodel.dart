import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test_riverpod/features/todos/domain/UseCase/delete_todo_usecase.dart';
import 'package:flutter_test_riverpod/features/todos/presentation/viewmodels/todolist/todo_list_viewmodel.dart';

import '../../domain/Model/todo.dart';
import '../../domain/Model/todo_list.dart';
import '../../domain/RepositoryInterface/todos_repository.dart';

final todoViewModelProvider =
    Provider.autoDispose.family<TodoViewModel, Todo?>((ref, todo) {
  return TodoViewModel(ref.read, todo);
});

class TodoViewModel {
  late final TodoListViewModel _todoListViewModel;
  late String _id;
  var _title = '';
  var _description = '';
  var _completed = false;
  var _isNewTodo = false;

  TodoViewModel(final Reader read, final Todo? todo) {
    _todoListViewModel = read(todoListViewModelProvider.notifier);
    if (todo == null) {
      _isNewTodo = true;
    } else {
      _id = todo.id;
      _title = todo.title;
      _description = todo.description;
      _completed = todo.completed;
    }
  }

  createOrUpdateTodo() {
    if (_isNewTodo) {
      _todoListViewModel.createTodo(_title, _description, _completed);
    } else {
      _todoListViewModel.updateTodo(_id, _title, _description, _completed);
    }
  }

  deleteTodo() {
    if (!_isNewTodo) _todoListViewModel.deleteTodo(_id);
  }

  String appBarTitle() => _isNewTodo ? 'Add ToDo' : 'Edit ToDo';

  String initialTitleValue() => _title;

  String initialDescriptionValue() => _description;

  bool shouldShowDeleteTodoIcon() => !_isNewTodo;

  setTitle(final String value) => _title = value;

  setDescription(final String value) => _description = value;

  setTodoStatus(final bool status) => _completed = status;

  String? validateTitle() {
    if (_title.isEmpty) {
      return 'Enter a title.';
    } else if (_title.length > 20) {
      return 'Limit the title to 20 characters.';
    } else {
      return null;
    }
  }

  String? validateDescription() {
    if (_description.length > 100) {
      return 'Limit the description to 100 characters.';
    } else {
      return null;
    }
  }
}
