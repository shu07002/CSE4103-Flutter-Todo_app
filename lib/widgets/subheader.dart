import 'package:flutter/material.dart';

class SubHeader extends StatelessWidget {
  final VoidCallback onDeleteAll;

  const SubHeader({super.key, required this.onDeleteAll});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          "ToDos",
          style: TextStyle(
            color: Colors.white,
            fontSize: 26,
            fontWeight: FontWeight.w600,
          ),
        ),
        TextButton(
          onPressed: onDeleteAll,
          child: Text(
            "Delete All",
            style: TextStyle(
              color: Colors.white.withValues(alpha: 0.8),
              fontSize: 12,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
      ],
    );
  }
}
