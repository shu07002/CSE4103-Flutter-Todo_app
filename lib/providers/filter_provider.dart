import 'package:flutter_riverpod/legacy.dart';

enum Filter {
  ALL("ALL"),
  HAVE_TO_DO("Have To Do"),
  DONE_TO_DO("Done To Do");

  const Filter(this.mark);
  final String mark;
}

final filterProvider = StateProvider<Filter>((ref) => Filter.ALL);
