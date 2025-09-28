import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:collection/collection.dart';
import 'package:nomad_flutter/models/todo.dart';
import 'package:nomad_flutter/providers/filter_provider.dart';
import 'package:nomad_flutter/providers/todo_provider.dart';

// 필터 적용된 id 목록만 제공 → 상위는 이것만 구독
final filteredTodoIdsProvider = Provider<List<String>>((ref) {
  final filter = ref.watch(filterProvider);
  final todos  = ref.watch(todosProvider);

  Iterable<ToDo> xs = todos;
  switch (filter) {
    case Filter.ALL: break;
    case Filter.HAVE_TO_DO: xs = xs.where((t) => !t.isDone); break;
    case Filter.DONE_TO_DO: xs = xs.where((t) =>  t.isDone); break;
  }
  return xs.map((t) => t.createdAt).toList(growable: false);
});

// 특정 항목만 구독 (셀에서 사용)
final todoByIdProvider = Provider.family<ToDo?, String>((ref, id) {
  return ref.watch(
    todosProvider.select(
          (list) => list.firstWhereOrNull((t) => t.createdAt == id),
    ),
  );
});
