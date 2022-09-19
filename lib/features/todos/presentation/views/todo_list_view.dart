import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test_riverpod/features/todos/domain/Model/todo_list.dart';
import 'package:flutter_test_riverpod/features/todos/presentation/views/todo_form_view.dart';

import '../viewmodels/todolist/todo_list_viewmodel.dart';

class TodoListView extends ConsumerWidget {
  final _todoListProvider = todoListViewModelProvider;

  TodoListView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final todos = ref.watch(_todoListProvider).todos;
    final listProvider = ref.read(_todoListProvider.notifier);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Todo List'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const TodoFormView(),
                ),
              );
            },
          ),
        ],
      ),
      body: DataTable(
        columns: _createTodoTableColumns(),
        rows: _createTodoTableRows(todos, listProvider, context),
      ),
    );
  }

  List<DataColumn> _createTodoTableColumns() {
    return [
      const DataColumn(label: Text('ID')),
      const DataColumn(label: Text('Todo')),
      const DataColumn(label: Text('Delete')),
      const DataColumn(label: Text('Details')),
    ];
  }

  List<DataRow> _createTodoTableRows(
      TodoList? todos, TodoListViewModel todoViewModel, BuildContext context) {
    if (todos != null) {
      return todos.todos.map((todo) {
        return DataRow(
          cells: [
            DataCell(Text('#${todo.id}')),
            DataCell(Text(todo.title)),
            DataCell(IconButton(
              icon: const Icon(Icons.delete),
              onPressed: () async {
                await todoViewModel.deleteTodo(todo.id);
              },
            )),
            DataCell(IconButton(
              icon: const Icon(Icons.edit),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => TodoFormView(todo: todo),
                  ),
                );
              },
            )),
          ],
        );
      }).toList();
    } else {
      return [];
    }
  }
}
