import 'package:flutter/material.dart';
import 'package:noteapp/core/theme/app_colors.dart';

class NoteColorPicker extends StatelessWidget {
  const NoteColorPicker({
    super.key,
    required this.selected,
    required this.onChanged,
  });

  final int selected;
  final ValueChanged<int> onChanged;

  @override
  Widget build(BuildContext context) {
    final primary = Theme.of(context).colorScheme.primary;
    return Wrap(
      spacing: 12,
      runSpacing: 12,
      children: [
        for (final c in AppColors.noteColors)
          GestureDetector(
            onTap: () => onChanged(c),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                color: Color(c),
                shape: BoxShape.circle,
                border: Border.all(
                  color: selected == c ? primary : Colors.transparent,
                  width: 3,
                ),
              ),
              child: AnimatedScale(
                duration: const Duration(milliseconds: 200),
                scale: selected == c ? 1 : 0,
                child: const Icon(Icons.check_rounded, color: AppColors.onNote),
              ),
            ),
          ),
      ],
    );
  }
}
