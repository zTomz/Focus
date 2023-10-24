import 'package:uuid/uuid.dart';

class Todo {
  final String title;
  bool isDone;
  final DateTime createdAt;
  final String uuid;

  Todo({
    required this.title,
    required this.isDone,
    required this.createdAt,
    required this.uuid,
  });

  static Todo fromTitle(String title) {
    return Todo(
      title: title,
      isDone: false,
      createdAt: DateTime.now(),
      uuid: const Uuid().v4(),
    );
  }
}
