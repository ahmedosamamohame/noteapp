import 'package:equatable/equatable.dart';
import 'package:noteapp/features/notes/data/models/note_model.dart';

enum NotesStatus { initial, success, failure }

enum NotesSort { newest, oldest, title }

class NotesState extends Equatable {
  const NotesState({
    this.status = NotesStatus.initial,
    this.notes = const [],
    this.query = '',
    this.sort = NotesSort.newest,
    this.error,
    this.revision = 0,
  });

  final NotesStatus status;
  final List<NoteModel> notes;
  final String query;
  final NotesSort sort;
  final String? error;

  final int revision;

  List<NoteModel> get visibleNotes {
    final q = query.trim().toLowerCase();
    final list = notes
        .where((n) =>
            q.isEmpty ||
            n.title.toLowerCase().contains(q) ||
            n.content.toLowerCase().contains(q))
        .toList();

    list.sort((a, b) {
      if (a.isPinned != b.isPinned) return a.isPinned ? -1 : 1;
      return switch (sort) {
        NotesSort.newest => b.createdAt.compareTo(a.createdAt),
        NotesSort.oldest => a.createdAt.compareTo(b.createdAt),
        NotesSort.title =>
          a.title.toLowerCase().compareTo(b.title.toLowerCase()),
      };
    });
    return list;
  }

  NotesState copyWith({
    NotesStatus? status,
    List<NoteModel>? notes,
    String? query,
    NotesSort? sort,
    String? error,
  }) {
    return NotesState(
      status: status ?? this.status,
      notes: notes ?? this.notes,
      query: query ?? this.query,
      sort: sort ?? this.sort,
      error: error,
      revision: revision + 1,
    );
  }

  @override
  List<Object?> get props => [status, notes, query, sort, error, revision];
}
