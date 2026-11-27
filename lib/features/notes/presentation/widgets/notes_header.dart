import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:noteapp/core/constants/app_constants.dart';
import 'package:noteapp/core/theme/theme_cubit.dart';
import 'package:noteapp/features/notes/presentation/cubit/notes_cubit.dart';
import 'package:noteapp/features/notes/presentation/cubit/notes_state.dart';

class NotesHeader extends StatelessWidget {
  const NotesHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      children: [
        Row(
          children: [
            Text(
              AppConstants.appName,
              style: theme.textTheme.headlineLarge
                  ?.copyWith(fontWeight: FontWeight.w700),
            ),
            const Spacer(),
            PopupMenuButton<NotesSort>(
              icon: const Icon(Icons.sort_rounded),
              onSelected: context.read<NotesCubit>().changeSort,
              itemBuilder: (_) => const <PopupMenuEntry<NotesSort>>[
                PopupMenuItem(value: NotesSort.newest, child: Text('Newest first')),
                PopupMenuItem(value: NotesSort.oldest, child: Text('Oldest first')),
                PopupMenuItem(value: NotesSort.title, child: Text('By title')),
              ],
            ),
            BlocBuilder<ThemeCubit, ThemeMode>(
              builder: (context, mode) => IconButton(
                onPressed: context.read<ThemeCubit>().toggle,
                icon: Icon(
                  mode == ThemeMode.dark
                      ? Icons.light_mode_rounded
                      : Icons.dark_mode_rounded,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        TextField(
          onChanged: context.read<NotesCubit>().search,
          decoration: const InputDecoration(
            hintText: 'Search notes...',
            prefixIcon: Icon(Icons.search_rounded),
          ),
        ),
      ],
    ).animate().fadeIn(duration: 400.ms).slideY(begin: -.1, curve: Curves.easeOut);
  }
}
