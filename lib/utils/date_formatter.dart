String formatDate(DateTime dt) {
  String twoDigits(int n) => n.toString().padLeft(2, '0');
  return "${dt.year}-${twoDigits(dt.month)}-${twoDigits(dt.day)} "
      "${twoDigits(dt.hour)}:${twoDigits(dt.minute)}:${twoDigits(dt.second)}";
}