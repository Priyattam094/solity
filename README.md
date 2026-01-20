# Solity - Private Digital Diary

<p align="center">
  <img src="assets/icon/icon.png" alt="Solity Logo" width="120" height="120">
</p>

<p align="center">
  <strong>A privacy-first, offline digital diary built with Flutter</strong>
</p>

<p align="center">
  <img src="https://img.shields.io/badge/Flutter-3.8+-02569B?style=flat-square&logo=flutter" alt="Flutter">
  <img src="https://img.shields.io/badge/Dart-3.0+-0175C2?style=flat-square&logo=dart" alt="Dart">
  <img src="https://img.shields.io/badge/Platform-Android%20%7C%20iOS-green?style=flat-square" alt="Platform">
  <img src="https://img.shields.io/badge/Architecture-Clean%20Architecture-purple?style=flat-square" alt="Architecture">
  <img src="https://img.shields.io/badge/License-MIT-blue?style=flat-square" alt="License">
</p>

---

## Overview

**Solity** is a mobile diary application that prioritizes user privacy and simplicity. Unlike most journaling apps that require accounts and sync data to the cloud, Solity keeps all your personal thoughts completely offline on your device.

Built with **Clean Architecture** principles and modern Flutter development practices, this project demonstrates proficiency in mobile app development, state management, and software design patterns.

<b>I made this application specifically to learn app authentication and app lock.</b>
---

## Key Features

| Feature | Description |
|---------|-------------|
| **Offline-First** | All data stored locally using Hive - no internet required |
| **Biometric Security** | Fingerprint/Face ID lock to protect your entries |
| **Clean UI/UX** | Distraction-free writing experience with thoughtful animations |
| **Multiple Themes** | Light, Dark, and Dim modes for comfortable reading |
| **Data Export** | Export entries as formatted text or JSON |
| **Zero Tracking** | No analytics, no ads, no data collection |

---

## Technical Architecture

This project follows **Clean Architecture** to ensure separation of concerns, testability, and maintainability.

```
lib/
├── app/                    # Application configuration
│   ├── app.dart           # Root widget with theme management
│   └── routes.dart        # GoRouter navigation configuration
│
├── core/                   # Shared utilities and constants
│   ├── constants/         # App colors, dimensions, typography
│   ├── theme/             # Theme data and styling
│   └── utils/             # Helper functions (date formatting)
│
├── data/                   # Data layer
│   ├── models/            # Hive data models with adapters
│   └── repositories/      # Repository implementations
│
├── domain/                 # Business logic layer
│   ├── entities/          # Core business objects
│   └── repositories/      # Repository interfaces (contracts)
│
├── presentation/           # UI layer
│   ├── providers/         # Riverpod state management
│   ├── screens/           # Feature screens
│   └── widgets/           # Reusable UI components
│
└── services/               # Platform services
    ├── hive_service.dart          # Local database service
    ├── local_auth_service.dart    # Biometric authentication
    └── secure_window_service.dart # Screen security
```

### Architecture Highlights

- **Dependency Inversion**: Repository interfaces in domain layer, implementations in data layer
- **Single Responsibility**: Each class has one clear purpose
- **Immutable State**: Using `copyWith` patterns for safe state updates
- **Reactive UI**: Riverpod providers automatically rebuild UI on state changes

---

## Tech Stack

| Category | Technology |
|----------|------------|
| **Framework** | Flutter 3.8+ |
| **Language** | Dart 3.0+ |
| **State Management** | Riverpod (StateNotifier pattern) |
| **Local Database** | Hive (NoSQL, lightweight) |
| **Navigation** | GoRouter (declarative routing) |
| **Security** | local_auth, flutter_secure_storage |
| **Code Generation** | build_runner, hive_generator |
| **Typography** | Google Fonts (Nunito) |

---

## Getting Started

### Prerequisites

- Flutter SDK 3.8 or higher
- Dart 3.0 or higher
- Android Studio / VS Code with Flutter extensions

### Installation

```bash
# Clone the repository
git clone https://github.com/Priyattam094/solity.git
cd solity

# Install dependencies
flutter pub get

# Generate Hive adapters (if needed)
flutter pub run build_runner build --delete-conflicting-outputs

# Run the app
flutter run
```

### Build

```bash
# Android APK
flutter build apk --release

# iOS (requires macOS)
flutter build ios --release
```

---

## Code Quality Highlights

### State Management with Riverpod

```dart
// Clean provider pattern with dependency injection
final diaryNotifierProvider = StateNotifierProvider<DiaryNotifier, AsyncValue<List<DiaryEntry>>>((ref) {
  final repository = ref.watch(diaryRepositoryProvider);
  return DiaryNotifier(repository, ref);
});
```

### Repository Pattern

```dart
// Interface in domain layer
abstract class DiaryRepository {
  Future<List<DiaryEntry>> getAllEntries();
  Future<DiaryEntry> createEntry(String content);
  Stream<List<DiaryEntry>> watchAllEntries();
}

// Implementation in data layer with Hive
class DiaryRepositoryImpl implements DiaryRepository {
  // Concrete implementation details hidden from business logic
}
```

### Immutable Entities

```dart
class DiaryEntry {
  final String id;
  final String content;
  final DateTime createdAt;
  final DateTime updatedAt;

  DiaryEntry copyWith({String? content}) => DiaryEntry(
    id: id,
    content: content ?? this.content,
    createdAt: createdAt,
    updatedAt: DateTime.now(),
  );
}
```

---

## Design Philosophy

1. **Privacy by Design** - No accounts, no cloud sync, no tracking
2. **Simplicity** - Minimal UI, maximum focus on writing
3. **Performance** - Lightweight local storage, fast startup
4. **Security** - Biometric lock, secure storage for sensitive data

---

## Screenshots
<img width="390" height="849" alt="image" src="https://github.com/user-attachments/assets/4d24f2cb-f592-4c08-9aa6-22e4263e226e" />
<img width="395" height="865" alt="image" src="https://github.com/user-attachments/assets/87c7d2a2-71f6-4af3-a3b7-22f2e05e4d76" />
<img width="400" height="857" alt="image" src="https://github.com/user-attachments/assets/9ce0447a-2451-41e1-b565-66714e340504" />
<img width="387" height="849" alt="image" src="https://github.com/user-attachments/assets/3300cd19-dd8b-4974-9a1e-09b6da896b86" />



<!-- Uncomment when screenshots are available
<p align="center">
  <img src="screenshots/home.png" width="200" alt="Home Screen">
  <img src="screenshots/write.png" width="200" alt="Write Screen">
  <img src="screenshots/entries.png" width="200" alt="Entries Screen">
  <img src="screenshots/settings.png" width="200" alt="Settings Screen">
</p>
-->

---

## Future Enhancements

- [ ] Markdown support for rich text formatting
- [ ] Entry tags and categories
- [ ] Search with date filters
- [ ] Backup/restore functionality
- [ ] Widget for quick entry from home screen

---

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

---

<p align="center">
  Built with Flutter | Designed for Privacy
</p>
