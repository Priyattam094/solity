# 🎨 Solity Design System

> A comprehensive UI/UX guide for building calm, private, and intentional apps.  
> Use this as a reference for creating consistent, high-quality experiences.

---

## 📋 Table of Contents

1. [Design Philosophy](#design-philosophy)
2. [Core Principles](#core-principles)
3. [Color System](#color-system)
4. [Typography](#typography)
5. [Spacing & Dimensions](#spacing--dimensions)
6. [Shadows & Depth](#shadows--depth)
7. [Components](#components)
8. [Screen Patterns](#screen-patterns)
9. [Animations & Transitions](#animations--transitions)
10. [Do's and Don'ts](#dos-and-donts)
11. [Implementation in Flutter](#implementation-in-flutter)

---

## 🧠 Design Philosophy

### Positioning

> **Private. Offline. No Account.**  
> *Your inner world stays on your device.*

### The Feeling

Solity should feel like:
- Opening a **quiet notebook**
- Entering a **personal space**
- **Not being watched**
- **Not being rushed**

### The Question

For every design decision, ask:

> "Does this feel **safe, calm, and personal**?"

If not → **remove it**.

---

## 🎯 Core Principles

### 1️⃣ Silence Over Noise

| ❌ Avoid | ✅ Embrace |
|----------|------------|
| Popups | Subtle inline messages |
| Badges | Clean, minimal indicators |
| Red alerts | Muted semantic colors |
| Streak pressure | Gentle invitations |

Solity is **not** a habit-tracker.  
It's a *reflection space*.

---

### 2️⃣ One Thought at a Time

Never overwhelm the user.

At any moment, show:
- **One primary action**
- **One primary emotion**

Example Home Screen:
```
┌─────────────────────────────────┐
│                                 │
│       December 22, 2024         │ ← Date (small, faded)
│                                 │
│                                 │
│   "What's on your mind today?"  │ ← Single prompt
│                                 │
│                                 │
│          [ Write ]              │ ← One action
│                                 │
│                                 │
└─────────────────────────────────┘
```

---

### 3️⃣ Touch-First, Not Button-First

| Interaction | Implementation |
|-------------|----------------|
| Navigation | Swipe gestures |
| Selection | Large tap areas (min 48dp) |
| Actions | Floating, contextual |
| Saving | Swipe down to save |

Feels like *turning pages*, not using software.

---

### 4️⃣ Emotional Consistency

Every element must answer:
- Is this calming?
- Does this feel safe?
- Is this personal?
- Does this respect the user?

---

## 🎨 Color System

### Primary Palette

| Name | Hex | Usage |
|------|-----|-------|
| **Primary** | `#1E3A5F` | Trust, privacy, depth |
| Primary Light | `#2C4A6E` | Hover states |
| Primary Dark | `#152A45` | Pressed states |

### Text Colors (Warm Gray)

| Name | Hex | Usage |
|------|-----|-------|
| Text Primary | `#3A3A3A` | Main body text |
| Text Secondary | `#6B6B6B` | Subtitles, captions |
| Text Tertiary | `#9A9A9A` | Placeholders, hints |
| Text on Primary | `#FAF9F7` | Text on primary color |

### Light Theme Backgrounds

| Name | Hex | Usage |
|------|-----|-------|
| Background | `#FAF9F7` | Main scaffold (muted off-white) |
| Surface | `#FFFFFF` | Cards, inputs |
| Card | `#FFFFFF` | Entry cards |
| Divider | `#EEEEEB` | Subtle separators |

### Dark Theme Colors

| Name | Hex | Usage |
|------|-----|-------|
| Background Dark | `#1A1A1E` | Main scaffold |
| Surface Dark | `#242428` | Cards, inputs |
| Card Dark | `#2C2C32` | Entry cards |
| Text Primary Dark | `#E8E8E8` | Main text |
| Text Secondary Dark | `#B0B0B0` | Subtitles |

### Dim Theme (Night Reading)

| Name | Hex | Usage |
|------|-----|-------|
| Background Dim | `#121214` | Ultra dark background |
| Surface Dim | `#1A1A1C` | Cards |
| Card Dim | `#222224` | Entry cards |
| Text Primary Dim | `#D0D0D0` | Main text (reduced brightness) |
| Text Secondary Dim | `#8A8A8A` | Subtitles |

### Accent Colors

| Name | Hex | Usage |
|------|-----|-------|
| Accent | `#5B8CB8` | Selected states, links |
| Accent Light | `#7BA8D0` | Hover, highlights |

### Semantic Colors (Muted)

| Name | Hex | Usage |
|------|-----|-------|
| Success | `#5A8A6E` | Positive feedback |
| Error | `#C67B7B` | Errors (not harsh red) |
| Warning | `#D4A574` | Warnings (warm) |

### Color Rules

> ⚠️ **No pure black** (`#000000`)  
> ⚠️ **No harsh white** (`#FFFFFF` only for surface, not background)

### Flutter Implementation

```dart
class AppColors {
  AppColors._();

  // Primary
  static const Color primary = Color(0xFF1E3A5F);
  static const Color primaryLight = Color(0xFF2C4A6E);
  static const Color primaryDark = Color(0xFF152A45);

  // Text - Warm Gray
  static const Color textPrimary = Color(0xFF3A3A3A);
  static const Color textSecondary = Color(0xFF6B6B6B);
  static const Color textTertiary = Color(0xFF9A9A9A);
  static const Color textOnPrimary = Color(0xFFFAF9F7);

  // Backgrounds - Light
  static const Color backgroundLight = Color(0xFFFAF9F7);
  static const Color surfaceLight = Color(0xFFFFFFFF);
  static const Color cardLight = Color(0xFFFFFFFF);

  // Backgrounds - Dark
  static const Color backgroundDark = Color(0xFF1A1A1E);
  static const Color surfaceDark = Color(0xFF242428);
  static const Color cardDark = Color(0xFF2C2C32);
  static const Color textPrimaryDark = Color(0xFFE8E8E8);
  static const Color textSecondaryDark = Color(0xFFB0B0B0);

  // Backgrounds - Dim
  static const Color backgroundDim = Color(0xFF121214);
  static const Color surfaceDim = Color(0xFF1A1A1C);
  static const Color cardDim = Color(0xFF222224);
  static const Color textPrimaryDim = Color(0xFFD0D0D0);
  static const Color textSecondaryDim = Color(0xFF8A8A8A);

  // Accent
  static const Color accent = Color(0xFF5B8CB8);
  static const Color accentLight = Color(0xFF7BA8D0);

  // Semantic
  static const Color success = Color(0xFF5A8A6E);
  static const Color error = Color(0xFFC67B7B);
  static const Color warning = Color(0xFFD4A574);

  // Dividers
  static const Color dividerLight = Color(0xFFEEEDEB);
  static const Color dividerDark = Color(0xFF3A3A3E);
}
```

---

## 🅰️ Typography

### Font Family

**Primary:** Nunito (Google Fonts)

- Sans-serif
- Human, rounded
- Highly readable
- Excellent for night reading

### Type Scale

| Style | Size | Weight | Line Height | Usage |
|-------|------|--------|-------------|-------|
| Display Large | 32px | SemiBold (600) | 1.3 | Hero text |
| Display Medium | 28px | SemiBold (600) | 1.3 | Section titles |
| Headline Large | 24px | SemiBold (600) | 1.4 | Screen titles |
| Headline Medium | 20px | SemiBold (600) | 1.4 | Card titles |
| Title Large | 18px | Medium (500) | 1.4 | Subtitles |
| Title Medium | 16px | Medium (500) | 1.4 | List items |
| Body Large | 16px | Regular (400) | 1.6 | Body text |
| Body Medium | 14px | Regular (400) | 1.6 | Secondary text |
| Label Large | 14px | Medium (500) | 1.4 | Buttons |
| Label Small | 12px | Medium (500) | 1.4 | Captions, hints |

### Typography Rules

- **Medium line-height** (1.5-1.6) for readability
- **No condensed fonts**
- **Text should be readable at night**
- **Generous letter spacing** for titles

### Flutter Implementation

```dart
import 'package:google_fonts/google_fonts.dart';

TextTheme _buildTextTheme(Color primary, Color secondary) {
  return TextTheme(
    displayLarge: GoogleFonts.nunito(
      fontSize: 32,
      fontWeight: FontWeight.w600,
      color: primary,
      height: 1.3,
    ),
    displayMedium: GoogleFonts.nunito(
      fontSize: 28,
      fontWeight: FontWeight.w600,
      color: primary,
      height: 1.3,
    ),
    headlineLarge: GoogleFonts.nunito(
      fontSize: 24,
      fontWeight: FontWeight.w600,
      color: primary,
      height: 1.4,
    ),
    headlineMedium: GoogleFonts.nunito(
      fontSize: 20,
      fontWeight: FontWeight.w600,
      color: primary,
      height: 1.4,
    ),
    titleLarge: GoogleFonts.nunito(
      fontSize: 18,
      fontWeight: FontWeight.w500,
      color: primary,
      height: 1.4,
    ),
    titleMedium: GoogleFonts.nunito(
      fontSize: 16,
      fontWeight: FontWeight.w500,
      color: primary,
      height: 1.4,
    ),
    bodyLarge: GoogleFonts.nunito(
      fontSize: 16,
      fontWeight: FontWeight.w400,
      color: primary,
      height: 1.6,
    ),
    bodyMedium: GoogleFonts.nunito(
      fontSize: 14,
      fontWeight: FontWeight.w400,
      color: secondary,
      height: 1.6,
    ),
    labelLarge: GoogleFonts.nunito(
      fontSize: 14,
      fontWeight: FontWeight.w500,
      color: primary,
      height: 1.4,
    ),
    labelSmall: GoogleFonts.nunito(
      fontSize: 12,
      fontWeight: FontWeight.w500,
      color: secondary,
      height: 1.4,
    ),
  );
}
```

---

## 📐 Spacing & Dimensions

### Spacing Scale

| Name | Value | Usage |
|------|-------|-------|
| XXS | 4px | Tight spacing |
| XS | 8px | Compact elements |
| SM | 12px | Small gaps |
| MD | 16px | Default spacing |
| LG | 24px | Section gaps |
| XL | 32px | Large sections |
| XXL | 48px | Major divisions |
| XXXL | 64px | Page-level spacing |

### Border Radius

| Name | Value | Usage |
|------|-------|-------|
| XS | 4px | Small elements |
| SM | 8px | Chips, small buttons |
| MD | 12px | Buttons, inputs |
| LG | 16px | Cards |
| XL | 24px | Large cards, sheets |
| Full | 999px | Pills, avatars |

### Specific Radii

| Element | Radius |
|---------|--------|
| Cards | 16px |
| Buttons | 12px |
| Inputs | 12px |

### Flutter Implementation

```dart
class AppDimensions {
  AppDimensions._();

  // Spacing
  static const double spacingXxs = 4.0;
  static const double spacingXs = 8.0;
  static const double spacingSm = 12.0;
  static const double spacingMd = 16.0;
  static const double spacingLg = 24.0;
  static const double spacingXl = 32.0;
  static const double spacingXxl = 48.0;
  static const double spacingXxxl = 64.0;

  // Border Radius
  static const double radiusXs = 4.0;
  static const double radiusSm = 8.0;
  static const double radiusMd = 12.0;
  static const double radiusLg = 16.0;
  static const double radiusXl = 24.0;
  static const double radiusFull = 999.0;

  // Specific
  static const double cardRadius = 16.0;
  static const double buttonRadius = 12.0;
  static const double inputRadius = 12.0;

  // Padding Presets
  static const EdgeInsets pagePadding = EdgeInsets.symmetric(
    horizontal: spacingLg,  // 24px
    vertical: spacingMd,    // 16px
  );

  static const EdgeInsets cardPadding = EdgeInsets.all(spacingMd);  // 16px

  static const EdgeInsets writingPadding = EdgeInsets.symmetric(
    horizontal: spacingXl,  // 32px - wide margins for writing
    vertical: spacingLg,    // 24px
  );
}
```

---

## 🌫️ Shadows & Depth

### Shadow Philosophy

- **Very soft shadows**
- **No sharp borders**
- **Cards feel like paper, not tiles**

### Shadow Scale

#### Soft Shadow (Default)

```dart
static List<BoxShadow> get shadowSoft => [
  BoxShadow(
    color: Colors.black.withOpacity(0.04),
    blurRadius: 8,
    offset: const Offset(0, 2),
  ),
  BoxShadow(
    color: Colors.black.withOpacity(0.02),
    blurRadius: 16,
    offset: const Offset(0, 4),
  ),
];
```

#### Medium Shadow (Cards, FAB)

```dart
static List<BoxShadow> get shadowMedium => [
  BoxShadow(
    color: Colors.black.withOpacity(0.06),
    blurRadius: 12,
    offset: const Offset(0, 4),
  ),
  BoxShadow(
    color: Colors.black.withOpacity(0.03),
    blurRadius: 24,
    offset: const Offset(0, 8),
  ),
];
```

#### Elevated Shadow (Modals, Sheets)

```dart
static List<BoxShadow> get shadowElevated => [
  BoxShadow(
    color: Colors.black.withOpacity(0.08),
    blurRadius: 16,
    offset: const Offset(0, 8),
  ),
  BoxShadow(
    color: Colors.black.withOpacity(0.04),
    blurRadius: 32,
    offset: const Offset(0, 16),
  ),
];
```

### Shadow Usage

| Element | Shadow |
|---------|--------|
| Entry cards | Soft |
| Floating buttons | Medium |
| Bottom sheets | Elevated |
| Dialogs | Elevated |

---

## 🧩 Components

### Entry Card

```dart
Container(
  decoration: BoxDecoration(
    color: AppColors.cardLight,
    borderRadius: BorderRadius.circular(AppDimensions.cardRadius),
    boxShadow: AppDimensions.shadowSoft,
  ),
  padding: AppDimensions.cardPadding,
  child: Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(formattedDate, style: Theme.of(context).textTheme.labelSmall),
      SizedBox(height: AppDimensions.spacingXs),
      Text(
        entryPreview,
        style: Theme.of(context).textTheme.bodyLarge,
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
      ),
    ],
  ),
)
```

### Primary Button

```dart
ElevatedButton(
  onPressed: onPressed,
  style: ElevatedButton.styleFrom(
    backgroundColor: AppColors.primary,
    foregroundColor: AppColors.textOnPrimary,
    elevation: 0,
    padding: EdgeInsets.symmetric(
      horizontal: AppDimensions.spacingLg,
      vertical: AppDimensions.spacingMd,
    ),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(AppDimensions.buttonRadius),
    ),
  ),
  child: Text('Write'),
)
```

### Text Input

```dart
TextField(
  decoration: InputDecoration(
    filled: true,
    fillColor: AppColors.surfaceLight,
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(AppDimensions.inputRadius),
      borderSide: BorderSide.none,
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(AppDimensions.inputRadius),
      borderSide: BorderSide(color: AppColors.primary, width: 1.5),
    ),
    hintText: 'Start writing...',
    hintStyle: TextStyle(color: AppColors.textTertiary),
    contentPadding: EdgeInsets.all(AppDimensions.spacingMd),
  ),
)
```

### Settings Toggle

```dart
SwitchListTile(
  title: Text('App Lock'),
  subtitle: Text('Require authentication to open'),
  value: isEnabled,
  onChanged: onChanged,
  activeColor: AppColors.primary,
  contentPadding: EdgeInsets.symmetric(
    horizontal: AppDimensions.spacingMd,
  ),
)
```

---

## 📱 Screen Patterns

### 1. Home Screen - "Today"

**Purpose:** Ground the user in today, not the app.

```
┌─────────────────────────────────┐
│                                 │
│       December 22, 2024         │ ← Soft, small
│                                 │
│                                 │
│                                 │
│   "What's on your mind today?"  │ ← Centered prompt
│                                 │
│                                 │
│          [ Write ]              │ ← Primary CTA
│                                 │
│    ┌─────────────────────┐     │
│    │ Last entry preview  │     │ ← Optional, blurred
│    └─────────────────────┘     │
│                                 │
└─────────────────────────────────┘
```

**Key Elements:**
- Date at top (soft, small, faded)
- Single line prompt in center
- One primary button
- Optional last entry preview (1 line, subtle)

---

### 2. Write Screen - "Inner Space"

**Purpose:** Full immersion in writing.

```
┌─────────────────────────────────┐
│  ← December 22, 2024            │ ← Minimal header
├─────────────────────────────────┤
│                                 │
│                                 │
│    |                            │ ← Blinking cursor
│                                 │
│                                 │
│                                 │
│                                 │
│                                 │
│                                 │
│                                 │
│                                 │
│                        ○ Saved  │ ← Auto-save indicator
└─────────────────────────────────┘
```

**Rules:**
- Full-screen writing
- No toolbar initially
- Wide margins
- Cursor blinking = only movement
- Swipe down → Save & exit
- Long press → text options

---

### 3. Entries Screen - "Your Pages"

**Purpose:** Browse past entries like pages.

```
┌─────────────────────────────────┐
│         Your Entries            │
├─────────────────────────────────┤
│  ┌─────────────────────────┐   │
│  │ December 21, 2024       │   │
│  │ Today was a good day... │   │
│  └─────────────────────────┘   │
│                                 │
│  ┌─────────────────────────┐   │
│  │ December 20, 2024       │   │
│  │ I've been thinking...   │   │
│  └─────────────────────────┘   │
│                                 │
│  ┌─────────────────────────┐   │
│  │ December 18, 2024       │   │
│  │ The meeting went...     │   │
│  └─────────────────────────┘   │
│                                 │
└─────────────────────────────────┘
```

**Key Elements:**
- Vertical list of cards
- Each card shows: Date + First 1-2 lines
- No word count
- No analytics
- No streaks

---

### 4. Settings Screen - "Trust Center"

**Purpose:** Build trust, not showcase features.

```
┌─────────────────────────────────┐
│           Settings              │
├─────────────────────────────────┤
│  PRIVACY                        │
│  ─────────────────────────────  │
│  App Lock                    ○  │
│  Hide in Recent Apps         ○  │
│                                 │
│  DATA                           │
│  ─────────────────────────────  │
│  Export Diary                 → │
│  Local Backup                 → │
│                                 │
│  APPEARANCE                     │
│  ─────────────────────────────  │
│  Theme            Light/Dark/Dim│
│  Font Size             Medium → │
│                                 │
│  ABOUT                          │
│  ─────────────────────────────  │
│  Solity by Aestyr               │
│  "Private. Offline. No Account."│
│                                 │
└─────────────────────────────────┘
```

---

## ✨ Animations & Transitions

### Animation Duration

| Type | Duration | Curve |
|------|----------|-------|
| Micro | 150ms | easeOut |
| Short | 250ms | easeInOut |
| Medium | 350ms | easeInOut |
| Long | 500ms | easeInOut |

### Transition Patterns

#### Page Transitions
```dart
// Fade + Slide Up (preferred for content screens)
PageRouteBuilder(
  pageBuilder: (_, __, ___) => NewScreen(),
  transitionsBuilder: (_, animation, __, child) {
    return FadeTransition(
      opacity: animation,
      child: SlideTransition(
        position: Tween<Offset>(
          begin: Offset(0, 0.05),
          end: Offset.zero,
        ).animate(CurvedAnimation(
          parent: animation,
          curve: Curves.easeOut,
        )),
        child: child,
      ),
    );
  },
  transitionDuration: Duration(milliseconds: 300),
)
```

#### Button Feedback
```dart
// Subtle scale on press
AnimatedScale(
  scale: isPressed ? 0.98 : 1.0,
  duration: Duration(milliseconds: 100),
  child: button,
)
```

#### Save Indicator
```dart
// Fade in/out
AnimatedOpacity(
  opacity: showSaved ? 1.0 : 0.0,
  duration: Duration(milliseconds: 200),
  child: Text('Saved'),
)
```

---

## ✅ Do's and Don'ts

### ✅ DO

| Practice | Reason |
|----------|--------|
| Use muted, soft colors | Creates calm atmosphere |
| Generous whitespace | Reduces visual stress |
| Large tap targets (48dp+) | Comfortable interaction |
| Subtle animations | Feels polished, not distracting |
| Single primary action per screen | Clear direction |
| Rounded corners everywhere | Friendly, approachable |
| Consistent spacing | Professional, harmonious |
| Readable text at all sizes | Accessibility |
| Dark/Dim modes | Night reading comfort |
| Auto-save without prompts | Reduces anxiety |

### ❌ DON'T

| Avoid | Reason |
|-------|--------|
| Pure black (#000000) | Too harsh |
| Pure white backgrounds | Eye strain |
| Popups and modals (unless critical) | Interrupts flow |
| Badges and notifications | Creates pressure |
| Streak counters | Gamification ≠ reflection |
| Red error colors | Too alarming |
| Dense information | Overwhelming |
| Small tap targets | Frustrating |
| Harsh transitions | Jarring experience |
| Social features | Privacy concern |

---

## 🛠️ Implementation in Flutter

### Project Structure

```
lib/
├── core/
│   ├── constants/
│   │   ├── app_colors.dart      ← Color palette
│   │   └── app_dimensions.dart  ← Spacing, radii
│   ├── theme/
│   │   └── app_theme.dart       ← ThemeData definitions
│   └── utils/
│       └── extensions.dart      ← Helper extensions
├── presentation/
│   ├── screens/
│   │   ├── home_screen.dart
│   │   ├── write_screen.dart
│   │   ├── entries_screen.dart
│   │   └── settings_screen.dart
│   └── widgets/
│       ├── entry_card.dart
│       ├── solity_button.dart
│       └── settings_tile.dart
```

### Theme Setup (main.dart)

```dart
import 'package:flutter/material.dart';
import 'core/theme/app_theme.dart';

class SolityApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Solity',
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      themeMode: ThemeMode.system, // or ThemeMode.light/dark
      home: HomeScreen(),
    );
  }
}
```

### Using Design Tokens

```dart
// In any widget:
Container(
  padding: AppDimensions.cardPadding,
  margin: EdgeInsets.symmetric(horizontal: AppDimensions.spacingLg),
  decoration: BoxDecoration(
    color: Theme.of(context).cardTheme.color,
    borderRadius: BorderRadius.circular(AppDimensions.cardRadius),
    boxShadow: AppDimensions.shadowSoft,
  ),
  child: Text(
    'Entry content',
    style: Theme.of(context).textTheme.bodyLarge,
  ),
)
```

---

## 📱 App Icon Guidelines

### Icon Design

**Background:** Soft deep blue (`#1E3A5F`)

**Symbol Options:**
1. Minimal open book
2. Abstract "S" using two curves

**Rules:**
- No text
- No outlines
- Soft rounded shape
- Simple, recognizable

**Emotion:**
> Calm. Personal. Safe.

### Android Adaptive Icon

```
assets/
└── icon/
    ├── foreground.png   ← Symbol only, centered
    ├── background.png   ← Solid color or gradient
    └── monochrome.png   ← For themed icons
```

---

## 📝 Marketing Copy Guidelines

### Play Store Short Description
```
Private digital diary. Offline. No account.
```

### Full Description Tone
- Short paragraphs
- No emojis
- Calm language
- Focus on privacy

### Example:
```
Solity is a quiet place for your thoughts.
No sign-up. No cloud. No tracking.
Everything stays on your device.

Write freely. Reflect peacefully.
Your inner world remains truly private.
```

---

## 🚫 What Solity Should NEVER Do

| Feature | Why Not |
|---------|---------|
| Social sharing | Privacy concern |
| Cloud sync | Data leaves device |
| Account system | Unnecessary tracking |
| Streak pressure | Creates guilt |
| Motivational guilt | "You missed a day!" |
| Analytics/tracking | Violates trust |
| Ads | Distracting, invasive |
| In-app purchases | Pressure tactics |
| Notifications | Interrupts peace |
| Word counts/stats | Gamification |

---

## 🔗 Resources

### Dependencies

```yaml
dependencies:
  google_fonts: ^6.2.1
  flutter_riverpod: ^2.5.1
  go_router: ^14.6.2
  hive_flutter: ^1.1.0
  flutter_secure_storage: ^9.2.2
  local_auth: ^2.3.0
  intl: ^0.19.0
```

### References

- [Material Design 3](https://m3.material.io/)
- [Google Fonts - Nunito](https://fonts.google.com/specimen/Nunito)
- [Flutter Theming Guide](https://docs.flutter.dev/cookbook/design/themes)

---

*Last Updated: December 2024*  
*Solity Design System v1.0*  
*Created by Aestyr*

