import 'package:get_it/get_it.dart';
import 'package:hive_ce_flutter/adapters.dart';
import 'package:noteapp/core/constants/app_constants.dart';
import 'package:noteapp/core/theme/theme_cubit.dart';
import 'package:noteapp/features/notes/data/models/note_model.dart';
import 'package:noteapp/features/notes/data/repositories/notes_repository.dart';
import 'package:noteapp/features/notes/presentation/cubit/notes_cubit.dart';

final GetIt sl = GetIt.instance;

Future<void> setupLocator() async {
  final notesBox = await Hive.openBox<NoteModel>(AppConstants.notesBox);
  final settingsBox = await Hive.openBox(AppConstants.settingsBox);

  sl
    ..registerLazySingleton<NotesRepository>(() => HiveNotesRepository(notesBox))
    ..registerFactory(() => NotesCubit(sl<NotesRepository>()))
    ..registerFactory(() => ThemeCubit(settingsBox));
}
