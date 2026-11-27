import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:noteapp/core/constants/app_constants.dart';
import 'package:noteapp/core/di/service_locator.dart';
import 'package:noteapp/core/theme/app_theme.dart';
import 'package:noteapp/core/theme/theme_cubit.dart';
import 'package:noteapp/features/notes/presentation/cubit/notes_cubit.dart';
import 'package:noteapp/features/notes/presentation/views/notes_view.dart';

class NotesApp extends StatelessWidget {
  const NotesApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => sl<ThemeCubit>()),
        BlocProvider(create: (_) => sl<NotesCubit>()..load()),
      ],
      child: BlocBuilder<ThemeCubit, ThemeMode>(
        builder: (context, mode) {
          return MaterialApp(
            title: AppConstants.appName,
            debugShowCheckedModeBanner: false,
            themeMode: mode,
            theme: AppTheme.light,
            darkTheme: AppTheme.dark,
            home: const NotesView(),
          );
        },
      ),
    );
  }
}
