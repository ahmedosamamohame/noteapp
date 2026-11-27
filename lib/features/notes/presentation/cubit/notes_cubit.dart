import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:noteapp/features/notes/data/models/note_model.dart';
import 'package:noteapp/features/notes/data/repositories/notes_repository.dart';
import 'package:noteapp/features/notes/presentation/cubit/notes_state.dart';

class NotesCubit extends Cubit<NotesState> {
  NotesCubit(this._repository) : super(const NotesState());

  final NotesRepository _repository;
  NoteModel? _lastDeleted;

  void load() => _refresh();

  void search(String query) => emit(state.copyWith(query: query));

  void changeSort(NotesSort sort) => emit(state.copyWith(sort: sort));

  Future<void> addNote({
    required String title,
    required String content,
    required int color,
  }) {
    final now = DateTime.now();
    return _mutate(() => _repository.add(NoteModel(
          title: title,
          content: content,
          color: color,
          date: DateFormat('dd MMM yyyy').format(now),
          createdAt: now.millisecondsSinceEpoch,
        )));
  }

  Future<void> updateNote(
    NoteModel note, {
    required String title,
    required String content,
    required int color,
  }) {
    return _mutate(() {
      note
        ..title = title
        ..content = content
        ..color = color;
      return _repository.update(note);
    });
  }

  Future<void> togglePin(NoteModel note) {
    return _mutate(() {
      note.isPinned = !note.isPinned;
      return _repository.update(note);
    });
  }

  Future<void> deleteNote(NoteModel note) {
    _lastDeleted = note.copy();
    emit(state.copyWith(
      notes: state.notes.where((n) => n.key != note.key).toList(),
      status: NotesStatus.success,
    ));
    return _mutate(() => _repository.delete(note));
  }

  Future<void> undoDelete() async {
    final note = _lastDeleted;
    if (note == null) return;
    _lastDeleted = null;
    await _mutate(() => _repository.add(note));
  }

  void _refresh() {
    try {
      emit(state.copyWith(
        status: NotesStatus.success,
        notes: _repository.getNotes(),
      ));
    } catch (e) {
      emit(state.copyWith(status: NotesStatus.failure, error: e.toString()));
    }
  }

  Future<void> _mutate(Future<void> Function() action) async {
    try {
      await action();
      _refresh();
    } catch (e) {
      emit(state.copyWith(status: NotesStatus.failure, error: e.toString()));
    }
  }
}
