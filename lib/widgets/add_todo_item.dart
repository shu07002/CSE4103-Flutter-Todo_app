import 'package:flutter/material.dart';

class AddTodoItem extends StatelessWidget {
  final TextEditingController controller;
  final VoidCallback onAdd;

  const AddTodoItem({
    super.key,
    required this.controller,
    required this.onAdd,
  });

  @override
  Widget build(BuildContext context) {
    final bottomInset = MediaQuery.viewInsetsOf(context).bottom;

    return RepaintBoundary(
      child: Padding(
        padding: EdgeInsets.only(bottom: bottomInset),
        child: const SafeArea(
          top: false,
          child: _BarBody(),
        ),
      ),
    );
  }
}

class _BarBody extends StatelessWidget {
  const _BarBody();

  @override
  Widget build(BuildContext context) {
    final AddTodoItem parent =
    context.findAncestorWidgetOfExactType<AddTodoItem>()!;

    return Material(
      color: const Color(0xFF202020),
      elevation: 0,
      child: SizedBox(
        height: 64,
        child: Row(
          children: [
            const SizedBox(width: 16),
            Expanded(
              child: TextField(
                style: TextStyle(
                  color:Colors.white,
                ),
                controller: parent.controller,
                maxLines: 1,
                minLines: 1,
                autofocus: false,
                enableSuggestions: false,
                autocorrect: false,
                textInputAction: TextInputAction.done,
                scrollPadding: EdgeInsets.zero,
                decoration: const InputDecoration(
                  hintText: 'Add todo',
                  border: InputBorder.none,
                  isDense: true,
                  contentPadding: EdgeInsets.symmetric(vertical: 12),
                ),
                onSubmitted: (_) => parent.onAdd(),
              ),
            ),
            IconButton(
              icon: const Icon(Icons.send),
              onPressed: parent.onAdd,
            ),
          ],
        ),
      ),
    );
  }
}
