import 'package:hive_ce/hive.dart';

class NoteModel extends HiveObject {
  NoteModel({
    required this.title,
    required this.content,
    required this.date,
    required this.color,
    this.isPinned = false,
    int? createdAt,
  }) : createdAt = createdAt ?? DateTime.now().millisecondsSinceEpoch;

  String title;
  String content;
  String date;
  int color;
  bool isPinned;
  final int createdAt;

  NoteModel copy() => NoteModel(
        title: title,
        content: content,
        date: date,
        color: color,
        isPinned: isPinned,
        createdAt: createdAt,
      );
}

class NoteModelAdapter extends TypeAdapter<NoteModel> {
  @override
  int get typeId => 0;

  @override
  NoteModel read(BinaryReader reader) {
    final count = reader.readByte();
    final f = <int, dynamic>{
      for (var i = 0; i < count; i++) reader.readByte(): reader.read(),
    };
    return NoteModel(
      title: f[0] as String,
      content: f[1] as String,
      date: f[2] as String,
      color: (f[3] as num).toInt(),
      isPinned: (f[4] as bool?) ?? false,
      createdAt: (f[5] as num?)?.toInt(),
    );
  }

  @override
  void write(BinaryWriter writer, NoteModel obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.title)
      ..writeByte(1)
      ..write(obj.content)
      ..writeByte(2)
      ..write(obj.date)
      ..writeByte(3)
      ..write(obj.color)
      ..writeByte(4)
      ..write(obj.isPinned)
      ..writeByte(5)
      ..write(obj.createdAt);
  }
}
