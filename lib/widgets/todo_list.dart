import 'package:flutter/material.dart';
import 'package:nomad_flutter/models/todo.dart';
import 'package:nomad_flutter/widgets/todo_item.dart';

class TodoList extends StatelessWidget {
  final List<ToDo> todos;
  final void Function(String) onDelete;
  final void Function(ToDo) onDone;

  const TodoList({
    super.key,
    required this.todos,
    required this.onDelete,
    required this.onDone,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: todos.length,
      itemBuilder: (context, index) {
        final todo = todos[index];
        return TodoItem(
          createdAt: todo.createdAt,
          whatTodo: todo.whatToDo,
          isDone: todo.isDone,
          onDelete: () => onDelete(todo.createdAt),
          onDone: () => onDone(todo),
        );
      },
    );
  }
}