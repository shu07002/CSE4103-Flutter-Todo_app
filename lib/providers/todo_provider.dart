import 'package:flutter_riverpod/legacy.dart';
import 'package:nomad_flutter/models/todo.dart';
import 'package:nomad_flutter/providers/filter_provider.dart';

class TodosNotifier extends StateNotifier<List<ToDo>> {
  TodosNotifier() : super([]);

  void add(String text) {
    final newTodo = ToDo(createdAt: DateTime.now().toString(), whatToDo: text);
    state = [newTodo, ...state];
  }

  void delete(String createdAt) {
    state = state.where((todo) => todo.createdAt != createdAt).toList();
  }

  void deleteFiltered(Filter filter) {
    switch (filter) {
      case Filter.ALL:
        state = [];
        break;
      case Filter.HAVE_TO_DO:
        state = state.where((todo) => todo.isDone).toList();
        break;
      case Filter.DONE_TO_DO:
        state = state.where((todo) => !todo.isDone).toList();
        break;
    }
  }

  void toggleDone(String createdAt) {
    state = state
        .map(
          (todo) => todo.createdAt == createdAt
              ? ToDo(
                  createdAt: todo.createdAt,
                  whatToDo: todo.whatToDo,
                  isDone: !todo.isDone,
                )
              : todo,
        )
        .toList();
  }
}

final todosProvider = StateNotifierProvider<TodosNotifier, List<ToDo>>(
  (ref) => TodosNotifier(),
);

