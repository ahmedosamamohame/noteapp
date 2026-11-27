import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_ce_flutter/adapters.dart';

class ThemeCubit extends Cubit<ThemeMode> {
  ThemeCubit(Box box)
      : _box = box,
        super((box.get(_key, defaultValue: true) as bool)
            ? ThemeMode.dark
            : ThemeMode.light);

  static const String _key = 'isDark';
  final Box _box;

  void toggle() {
    final next = state == ThemeMode.dark ? ThemeMode.light : ThemeMode.dark;
    _box.put(_key, next == ThemeMode.dark);
    emit(next);
  }
}
