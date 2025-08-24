import 'package:hive/hive.dart';
part 'note.g.dart';

@HiveType(typeId: 0)
class Note {
  @HiveField(0)
  String title;

  @HiveField(1)
  String content;

  @HiveField(2)
  bool isFinished;

  Note({
    required this.title,
    required this.content,
    this.isFinished = false,
  });

  void save() {}
}
