import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nomad_flutter/providers/filter_provider.dart';
import 'package:nomad_flutter/providers/todo_provider.dart';
import 'package:nomad_flutter/widgets/add_todo_item.dart';
import 'package:nomad_flutter/widgets/button.dart';
import 'package:nomad_flutter/widgets/header.dart';
import 'package:nomad_flutter/widgets/subheader.dart';
import 'package:nomad_flutter/widgets/todo_item.dart';

import 'package:nomad_flutter/providers/filtered_todos_provider.dart';

class Home extends ConsumerStatefulWidget {
  const Home({super.key});
  @override
  ConsumerState<Home> createState() => _HomeState();
}

class _HomeState extends ConsumerState<Home> {
  late final TextEditingController _controller;
  static const _itemExtent = 76.0;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isEmpty = ref.watch(
      filteredTodoIdsProvider.select((ids) => ids.isEmpty),
    );

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: const Color(0xFF181818),
      body: CustomScrollView(
        slivers: [
          SliverPadding(
            padding: const EdgeInsets.only(top: 60, left: 25, right: 25),
            sliver: const SliverToBoxAdapter(child: Header()),
          ),
          const SliverToBoxAdapter(child: SizedBox(height: 50)),
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 25),
            sliver: SliverToBoxAdapter(
              child: _FilterAndCounterBar(itemExtent: _itemExtent),
            ),
          ),

          if (isEmpty)
            const SliverFillRemaining(
              hasScrollBody: false,
              child: _EmptyView(),
            )
          else
            _TodoSliver(itemExtent: _itemExtent),

          const SliverToBoxAdapter(child: SizedBox(height: 90)),
        ],
      ),
      bottomNavigationBar: AddTodoItem(
        controller: _controller,
        onAdd: () {
          final text = _controller.text.trim();
          if (text.isNotEmpty) {
            ref.read(todosProvider.notifier).add(text);
            _controller.clear();
          }
        },
      ),
    );
  }
}

class _EmptyView extends StatelessWidget {
  const _EmptyView();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: const [
          Text('No ToDos', style: TextStyle(color: Colors.grey, fontSize: 20)),
          SizedBox(width: 8),
          Icon(Icons.sentiment_dissatisfied, color: Colors.grey),
        ],
      ),
    );
  }
}

class _FilterAndCounterBar extends ConsumerWidget {
  const _FilterAndCounterBar({required this.itemExtent});
  final double itemExtent;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final filter = ref.watch(filterProvider);
    final filteredCount = ref.watch(
      filteredTodoIdsProvider.select((ids) => ids.length),
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SubHeader(
          onDeleteAll: () {
            final f = ref.read(filterProvider);
            ref.read(todosProvider.notifier).deleteFiltered(f);
          },
        ),
        const SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Filter: ${filter.mark}',
                style: const TextStyle(color: Colors.white)),
            Text('Total ToDos: $filteredCount',
                style: const TextStyle(color: Colors.white)),
          ],
        ),
        const SizedBox(height: 20),
        Row(
          children: [
            Expanded(
              child: Button(
                text: 'All',
                bgColor: Colors.white,
                onPressed: () =>
                ref.read(filterProvider.notifier).state = Filter.ALL,
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Button(
                text: 'Have To Do',
                bgColor: Colors.white,
                onPressed: () =>
                ref.read(filterProvider.notifier).state = Filter.HAVE_TO_DO,
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Button(
                text: 'Done To Do',
                bgColor: Colors.white,
                onPressed: () =>
                ref.read(filterProvider.notifier).state = Filter.DONE_TO_DO,
              ),
            ),
          ],
        ),
        const SizedBox(height: 20),
      ],
    );
  }
}

class _TodoSliver extends ConsumerWidget {
  const _TodoSliver({required this.itemExtent});
  final double itemExtent;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ids = ref.watch(filteredTodoIdsProvider);

    return SliverFixedExtentList(
      itemExtent: itemExtent,
      delegate: SliverChildBuilderDelegate(
            (context, index) {
          final id = ids[index];
          return RepaintBoundary(
            key: ValueKey(id),
            child: _TodoCell(id: id),
          );
        },
        childCount: ids.length,
        addAutomaticKeepAlives: false,
        addRepaintBoundaries: true,
        addSemanticIndexes: false,
      ),
    );
  }
}

class _TodoCell extends ConsumerWidget {
  const _TodoCell({required this.id, super.key});
  final String id;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final todo = ref.watch(todoByIdProvider(id));
    if (todo == null) return const SizedBox.shrink();

    return TodoItem(
      createdAt: todo.createdAt,
      whatTodo: todo.whatToDo,
      isDone: todo.isDone,
      onDelete: () => ref.read(todosProvider.notifier).delete(todo.createdAt),
      onDone:   () => ref.read(todosProvider.notifier).toggleDone(todo.createdAt),
    );
  }
}
