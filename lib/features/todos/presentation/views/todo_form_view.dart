import 'package:flutter/material.dart';

import '../../domain/Model/todo.dart';
import '../viewmodels/todo_viewmodel.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TodoFormView extends ConsumerStatefulWidget {
  final Todo? todo;

  const TodoFormView({super.key, this.todo});

  @override
  TodoFormViewState createState() => TodoFormViewState();
}

class TodoFormViewState extends ConsumerState<TodoFormView> {
  late final TodoViewModel _viewModel;

  TodoFormViewState();

  @override
  void initState() {
    super.initState();

    // _viewModel = context.read(todoViewModelProvider(widget._todo));
    _viewModel = ref.read(todoViewModelProvider(widget.todo));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_viewModel.appBarTitle()),
        actions: [
          if (_viewModel.shouldShowDeleteTodoIcon())
            _buildDeleteTodoIconWidget()
        ],
      ),
      body: _buildBodyWidget(),
    );
  }

  Widget _buildBodyWidget() {
    return Container(
      padding: const EdgeInsets.only(left: 16, top: 24, right: 16, bottom: 16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _buildTitleFormWidget(),
          _buildDescriptionFormWidget(),
          _buildSaveButtonWidget(),
        ],
      ),
    );
  }

  Widget _buildSaveButtonWidget() {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () {
          _viewModel.createOrUpdateTodo();
          Navigator.pop(context);
        },
        child: const Text('Save'),
      ),
    );
  }

  Widget _buildTitleFormWidget() {
    return TextFormField(
      initialValue: _viewModel.initialTitleValue(),
      maxLength: 20,
      onChanged: (value) => _viewModel.setTitle(value),
      validator: (_) => _viewModel.validateTitle(),
      decoration: const InputDecoration(
        icon: Icon(Icons.edit),
        labelText: 'Title',
        helperText: 'Required',
        border: OutlineInputBorder(),
      ),
    );
  }

  Widget _buildDescriptionFormWidget() {
    return TextFormField(
      initialValue: _viewModel.initialDescriptionValue(),
      maxLength: 150,
      onChanged: (value) => _viewModel.setDescription(value),
      validator: (_) => _viewModel.validateDescription(),
      decoration: const InputDecoration(
        icon: Icon(Icons.view_headline),
        labelText: 'Description',
        border: OutlineInputBorder(),
      ),
    );
  }

  Widget _buildDeleteTodoIconWidget() {
    return IconButton(
      onPressed: () => _showConfirmDeleteTodoDialog(),
      icon: const Icon(Icons.delete),
    );
  }

  _showConfirmDeleteTodoDialog() async {
    final bool result = await showDialog(
      context: context,
      builder: (_) {
        return AlertDialog(
          content: const Text('Delete ToDo?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context, false),
              child: const Text('CANCEL'),
            ),
            TextButton(
              onPressed: () => Navigator.pop(context, true),
              child: const Text('DELETE'),
            ),
          ],
        );
      },
    );
    if (result) {
      _viewModel.deleteTodo();
      Navigator.pop(context);
    }
  }
}
