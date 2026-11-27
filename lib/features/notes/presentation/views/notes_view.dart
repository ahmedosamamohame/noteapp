import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:noteapp/core/utils/app_routes.dart';
import 'package:noteapp/features/notes/presentation/cubit/notes_cubit.dart';
import 'package:noteapp/features/notes/presentation/cubit/notes_state.dart';
import 'package:noteapp/features/notes/presentation/views/note_editor_view.dart';
import 'package:noteapp/features/notes/presentation/widgets/notes_header.dart';
import 'package:noteapp/features/notes/presentation/widgets/notes_list.dart';

class NotesView extends StatelessWidget {
  const NotesView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<NotesCubit, NotesState>(
      listenWhen: (prev, curr) =>
          curr.status == NotesStatus.failure && prev.error != curr.error,
      listener: (context, state) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed: ${state.error}')),
        );
      },
      child: Scaffold(
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () =>
              Navigator.push(context, AppRoutes.fade(const NoteEditorView())),
          icon: const Icon(Icons.add_rounded),
          label: const Text('New note'),
        ),
        body: const SafeArea(
          child: Padding(
            padding: EdgeInsets.fromLTRB(20, 16, 20, 0),
            child: Column(
              children: [
                NotesHeader(),
                Expanded(child: NotesList()),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
