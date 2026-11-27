import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:noteapp/core/utils/app_routes.dart';
import 'package:noteapp/core/widgets/empty_state.dart';
import 'package:noteapp/features/notes/data/models/note_model.dart';
import 'package:noteapp/features/notes/presentation/cubit/notes_cubit.dart';
import 'package:noteapp/features/notes/presentation/cubit/notes_state.dart';
import 'package:noteapp/features/notes/presentation/views/note_editor_view.dart';
import 'package:noteapp/features/notes/presentation/widgets/note_card.dart';

class NotesList extends StatelessWidget {
  const NotesList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NotesCubit, NotesState>(
      builder: (context, state) {
        if (state.status == NotesStatus.initial) {
          return const Center(child: CircularProgressIndicator());
        }
        if (state.status == NotesStatus.failure && state.notes.isEmpty) {
          return EmptyState(
            icon: Icons.error_outline_rounded,
            title: 'Something went wrong',
            subtitle: state.error ?? '',
          );
        }

        final notes = state.visibleNotes;
        if (notes.isEmpty) {
          final searching = state.query.trim().isNotEmpty;
          return EmptyState(
            icon: searching ? Icons.search_off_rounded : Icons.note_add_outlined,
            title: searching ? 'No results' : 'No notes yet',
            subtitle: searching
                ? 'Try a different keyword'
                : 'Tap "New note" to create your first one',
          );
        }

        return ListView.separated(
          padding: const EdgeInsets.only(top: 16, bottom: 100),
          itemCount: notes.length,
          separatorBuilder: (_, __) => const SizedBox(height: 14),
          itemBuilder: (context, index) {
            final note = notes[index];
            return NoteCard(
              note: note,
              onTap: () => Navigator.push(
                context,
                AppRoutes.fade(NoteEditorView(note: note)),
              ),
              onDelete: () => _deleteWithUndo(context, note),
              onPin: () => context.read<NotesCubit>().togglePin(note),
            )
                .animate(key: ValueKey('note_${note.key}'))
                .fadeIn(delay: (index.clamp(0, 8) * 60).ms, duration: 350.ms)
                .slideY(begin: .15, curve: Curves.easeOutCubic);
          },
        );
      },
    );
  }

  void _deleteWithUndo(BuildContext context, NoteModel note) {
    final cubit = context.read<NotesCubit>();
    cubit.deleteNote(note);
    ScaffoldMessenger.of(context)
      ..clearSnackBars()
      ..showSnackBar(
        SnackBar(
          content: const Text('Note deleted'),
          action: SnackBarAction(label: 'Undo', onPressed: cubit.undoDelete),
        ),
      );
  }
}
