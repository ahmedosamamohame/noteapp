import 'package:flutter/material.dart';
import 'package:hive_ce_flutter/adapters.dart';
import 'package:noteapp/app.dart';
import 'package:noteapp/core/di/service_locator.dart';
import 'package:noteapp/features/notes/data/models/note_model.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(NoteModelAdapter());
  await setupLocator();
  runApp(const NotesApp());
}
