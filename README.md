# Notes App

A fast, local-first notes app built with **Flutter**, **Cubit (flutter_bloc)** and **Hive CE**, structured with a clean, feature-first architecture.

This is one of the practice projects from the early stage of my Flutter journey, built after VOC AI to sharpen three things: clean architecture, state management, and local persistence. It started as a basic notes screen and was rebuilt into a structured, animated, searchable app.

![Flutter](https://img.shields.io/badge/Flutter-02569B?logo=flutter&logoColor=white)
![Dart](https://img.shields.io/badge/Dart-0175C2?logo=dart&logoColor=white)
![State](https://img.shields.io/badge/State-Cubit-7C4DFF)
![Storage](https://img.shields.io/badge/Storage-Hive_CE-FFB300)

## Demo

[Watch the demo video](docs/demo.mp4)

## Features

- Create, edit and delete notes
- Pick a color for each note
- Pin important notes to the top
- Real-time search across titles and content
- Sort by newest, oldest or title
- Swipe to delete with an Undo action
- Light and dark themes, saved between launches
- Smooth animations: staggered list entrance, animated page transitions, animated empty state, animated color picker
- Works fully offline, all data is stored on the device

## Tech Stack

| Area | Technology |
| --- | --- |
| Framework | Flutter, Dart |
| State management | flutter_bloc (Cubit), Equatable |
| Local database | Hive CE (hive_ce, hive_ce_flutter) |
| Dependency injection | get_it |
| UI and animation | Material 3, flutter_animate, google_fonts |
| Utilities | intl |

## Architecture

The project follows a feature-first structure with a clear separation between data and presentation.

```
lib
├── main.dart
├── app.dart
├── core
│   ├── constants
│   │   └── app_constants.dart
│   ├── di
│   │   └── service_locator.dart
│   ├── theme
│   │   ├── app_colors.dart
│   │   ├── app_theme.dart
│   │   └── theme_cubit.dart
│   ├── utils
│   │   └── app_routes.dart
│   └── widgets
│       ├── custom_button.dart
│       ├── custom_text_field.dart
│       └── empty_state.dart
└── features
    └── notes
        ├── data
        │   ├── models
        │   │   └── note_model.dart
        │   └── repositories
        │       └── notes_repository.dart
        └── presentation
            ├── cubit
            │   ├── notes_cubit.dart
            │   └── notes_state.dart
            ├── views
            │   ├── notes_view.dart
            │   └── note_editor_view.dart
            └── widgets
                ├── color_picker.dart
                ├── note_card.dart
                ├── notes_header.dart
                └── notes_list.dart
```

### Key decisions

- **Repository pattern:** the Cubit depends on an abstract `NotesRepository`, not on Hive directly, so the storage layer can be replaced without touching the UI.
- **Single source of state:** one immutable `NotesState` holds the notes, the search query and the sort order. Filtering and sorting are derived from it.
- **Dependency injection:** repositories and cubits are registered once in `get_it`.
- **Design tokens:** colors, radii and box names live in one place, so a single change updates the whole app.
- **Backward-compatible storage:** the Hive adapter keeps the original type id and fields, and new fields fall back to defaults, so older saved notes keep working.
- **Optimistic delete:** the note disappears from the list immediately and can be restored with Undo.
- **No code generation:** the Hive adapter is written by hand, so `build_runner` is not required.

## Getting Started

Requirements: Flutter SDK (stable channel).

```
git clone https://github.com/ahmedosamamohame/noteapp.git
cd noteapp
flutter pub get
flutter run
```

## Roadmap

- Arabic and English localization
- Unit tests for the Cubits and widget tests
- Cloud backup and sync
- Reminders and note categories

## Author

**Ahmed Osama**
Flutter Developer

- GitHub: [ahmedosamamohame](https://github.com/ahmedosamamohame)
- LinkedIn: [Ahmed Osama](https://www.linkedin.com/in/YOUR-LINKEDIN-USERNAME)
