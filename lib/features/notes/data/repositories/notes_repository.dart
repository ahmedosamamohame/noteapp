import 'package:hive_ce/hive.dart';
import 'package:noteapp/features/notes/data/models/note_model.dart';

abstract class NotesRepository {
  List<NoteModel> getNotes();
  Future<void> add(NoteModel note);
  Future<void> update(NoteModel note);
  Future<void> delete(NoteModel note);
}

class HiveNotesRepository implements NotesRepository {
  HiveNotesRepository(this._box);

  final Box<NoteModel> _box;

  @override
  List<NoteModel> getNotes() => _box.values.toList();

  @override
  Future<void> add(NoteModel note) => _box.add(note);

  @override
  Future<void> update(NoteModel note) => note.save();

  @override
  Future<void> delete(NoteModel note) => note.delete();
}
