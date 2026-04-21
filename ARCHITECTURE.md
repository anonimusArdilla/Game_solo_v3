# Architecture

## Stack Choices

### Engine
- Flutter (UI shell and navigation)
- Flame (real-time game loop, deterministic simulation, collision system)

### State and DI
- GetIt: explicit dependency injection and lifecycle ownership
- ChangeNotifier for settings that must integrate with MaterialApp (locale)
- Riverpod available for feature modules that benefit from immutable state and testability

### Backend (Planned)
- Firebase (Remote Config, Analytics, Crashlytics, Cloud Firestore + Cloud Functions)
  - Remote Config adjusts ad frequency and economy caps without app updates.
  - Cloud Functions used for server-trusted leaderboard writes.

### Ads (Planned)
- Google Mobile Ads (AdMob) with mediation enabled via the AdMob console

## Module Boundaries

### `lib/game`
- Flame-only game loop, simulation, entities, collisions, and level runtime.

### `lib/ui`
- Flutter screens, menus, and overlays.
- Hosts Flame via `GameWidget` and attaches overlay widgets.

### `lib/core`
- Cross-cutting services: environment, DI, persistence, audio, localization, fonts.

## Flame ↔ Flutter Bridge

- `GameWidget` hosts a single `GameSoloGame` instance per gameplay session.
- UI overlays are registered via `overlayBuilderMap` and activated from the game using `game.overlays`.
- Pause/resume is owned by the game loop (`pauseEngine` / `resumeEngine`) and surfaced to UI overlays.

