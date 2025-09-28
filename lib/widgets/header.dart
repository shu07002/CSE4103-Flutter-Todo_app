import 'package:flutter/material.dart';

class Header extends StatelessWidget {
  const Header({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              "Hey, KyeongWoo Kim",
              style: TextStyle(
                color: Theme.of(context).textTheme.titleLarge!.color,
                fontSize: 28,
                fontWeight: FontWeight.w700,
              ),
            ),
            Text(
              "Welcome",
              style: TextStyle(
                color: Colors.white.withValues(alpha: 0.8),
                fontWeight: FontWeight.w200,
                fontSize: 20,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
