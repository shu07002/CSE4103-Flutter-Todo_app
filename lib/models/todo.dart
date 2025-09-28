class ToDo {
  String createdAt;
  String whatToDo;
  bool isDone;

  ToDo({required this.createdAt, required this.whatToDo, this.isDone = false});

  ToDo toggle() =>
      ToDo(createdAt: createdAt, whatToDo: whatToDo, isDone: !isDone);
}
