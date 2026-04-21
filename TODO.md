# TODO

Last updated: 2026-04-21

## Phase 1 — Init
- [~] Project init (2026-04-21)
  - [x] Flutter project created
  - [x] Workspace tooling pinned (Flutter SDK, Android SDK, JDK)
  - [x] `.env` + `.env.example` + env validator
  - [x] DI container foundation
  - [x] Lint rules (flame_lint)
  - [x] README + architecture docs

## Phase 2 — Core Scaffold
- [~] Core scaffold (2026-04-21)
  - [x] Flame `GameWidget` bridge + basic game loop
  - [x] Flutter UI shell (home, settings, game)
  - [x] i18n setup (EN, ZH, JA, KO, TH, ID)
  - [x] Audio manager + asset registry
  - [x] Font fallback loader + font assets

## Phase 3 — Gameplay Loop
- [ ] Gameplay loop
  - [ ] Controls, collisions, scoring, game over/retry
  - [ ] Level loader, checkpoints, deterministic update strategy

## Phase 4 — Progression & Economy
- [ ] Progression & economy
  - [ ] Coin economy + daily/login rewards
  - [ ] Skin shop (preview, equip, validation)
  - [ ] Achievements (unlock logic + notifications)
  - [ ] Rewarded/interstitial ad rules + cooldown logic

## Phase 5 — Backend & Sync
- [ ] Backend & sync
  - [ ] Cloud saves + async leaderboards
  - [ ] Remote config
  - [ ] Analytics + crash reporting

## Phase 6 — Polish & Performance
- [ ] Polish & performance
  - [ ] Object pooling, batching, haptics, particles
  - [ ] Localization layout verification

## Phase 7 — Production Prep
- [ ] Production prep
  - [ ] R8/Proguard + obfuscation
  - [ ] Signing config (keystore via `.env` + CI-safe)
  - [ ] App icon/splash/feature graphics + store metadata

