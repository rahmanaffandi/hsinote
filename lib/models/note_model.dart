import 'package:hive/hive.dart';

part 'note_model.g.dart'; // Not using codegen; adapter is written manually below

@HiveType(typeId: 0)
class NoteModel extends HiveObject {
  @HiveField(0)
  String id;

  @HiveField(1)
  String title;

  @HiveField(2)
  String content;

  @HiveField(3)
  bool isFinished;

  @HiveField(4)
  DateTime createdAt;

  NoteModel({
    required this.id,
    required this.title,
    required this.content,
    this.isFinished = false,
    DateTime? createdAt,
  }) : createdAt = createdAt ?? DateTime.now();
}

// Manual adapter (no build_runner required)
/*class NoteModelAdapter extends TypeAdapter<NoteModel> {
  @override
  final int typeId = 0;

  @override
  NoteModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{};
    for (var i = 0; i < numOfFields; i++) {
      fields[reader.readByte()] = reader.read();
    }
    return NoteModel(
      id: fields[0] as String,
      title: fields[1] as String,
      content: fields[2] as String,
      isFinished: fields[3] as bool,
      createdAt: fields[4] as DateTime,
    );
  }

  @override
  void write(BinaryWriter writer, NoteModel obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.title)
      ..writeByte(2)
      ..write(obj.content)
      ..writeByte(3)
      ..write(obj.isFinished)
      ..writeByte(4)
      ..write(obj.createdAt);
  }
}*/
