import 'package:flutter/material.dart';

class TodoItem extends StatelessWidget {
  final String createdAt;
  final String whatTodo;
  final bool isDone;
  final VoidCallback onDelete;
  final VoidCallback onDone;

  const TodoItem({
    super.key,
    required this.createdAt,
    required this.whatTodo,
    this.isDone = false,
    required this.onDelete,
    required this.onDone,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            color: Color(0xFF1F2123),
            borderRadius: BorderRadiusGeometry.circular(15),
          ),
          child: Padding(
            padding: const EdgeInsets.only(
              top: 15,
              bottom: 15,
              left: 5,
              right: 5,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 5),
                  child: IconButton(
                    onPressed: onDone,
                    icon: Icon(
                      isDone ? Icons.check_box : Icons.check_box_outline_blank,
                      size: 25,
                      color: isDone ? Colors.amber : Colors.grey,
                    ),
                  ),
                ),
                Flexible(
                  fit: FlexFit.tight,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        whatTodo,
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                      SizedBox(height: 5),
                      Text(
                        createdAt,
                        style: TextStyle(
                          color: Colors.white.withValues(alpha: 0.5),
                          fontSize: 12.5,
                        ),
                      ),
                    ],
                  ),
                ),
                IconButton(
                  icon: Icon(
                    Icons.delete_forever,
                    size: 30,
                    color: Colors.white,
                  ),
                  onPressed: onDelete,
                ),
              ],
            ),
          ),
        ),
        SizedBox(height: 20),
      ],
    );
  }
}