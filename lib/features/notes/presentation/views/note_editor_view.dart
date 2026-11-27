import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:noteapp/core/theme/app_colors.dart';
import 'package:noteapp/core/widgets/custom_button.dart';
import 'package:noteapp/core/widgets/custom_text_field.dart';
import 'package:noteapp/features/notes/data/models/note_model.dart';
import 'package:noteapp/features/notes/presentation/cubit/notes_cubit.dart';
import 'package:noteapp/features/notes/presentation/widgets/color_picker.dart';

class NoteEditorView extends StatefulWidget {
  const NoteEditorView({super.key, this.note});

  final NoteModel? note;

  @override
  State<NoteEditorView> createState() => _NoteEditorViewState();
}

class _NoteEditorViewState extends State<NoteEditorView> {
  final _formKey = GlobalKey<FormState>();
  late final _title = TextEditingController(text: widget.note?.title);
  late final _content = TextEditingController(text: widget.note?.content);
  late int _color = widget.note?.color ?? AppColors.noteColors.first;
  bool _saving = false;

  bool get _isEditing => widget.note != null;

  @override
  void dispose() {
    _title.dispose();
    _content.dispose();
    super.dispose();
  }

  Future<void> _save() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _saving = true);

    final cubit = context.read<NotesCubit>();
    final navigator = Navigator.of(context);
    final title = _title.text.trim();
    final content = _content.text.trim();

    if (_isEditing) {
      await cubit.updateNote(widget.note!,
          title: title, content: content, color: _color);
    } else {
      await cubit.addNote(title: title, content: content, color: _color);
    }
    navigator.pop();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(title: Text(_isEditing ? 'Edit note' : 'New note')),
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: ListView(
            padding: const EdgeInsets.all(20),
            children: [
              CustomTextField(
                controller: _title,
                hint: 'Title',
                autofocus: !_isEditing,
              ),
              const SizedBox(height: 16),
              CustomTextField(controller: _content, hint: 'Content', maxLines: 8),
              const SizedBox(height: 24),
              Text('Color', style: theme.textTheme.titleMedium),
              const SizedBox(height: 12),
              NoteColorPicker(
                selected: _color,
                onChanged: (c) => setState(() => _color = c),
              ),
              const SizedBox(height: 32),
              CustomButton(
                label: _isEditing ? 'Save changes' : 'Add note',
                isLoading: _saving,
                onPressed: _save,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
