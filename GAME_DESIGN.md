# Game Design — Lantern Drift

## Core Concept

You guide a lantern drifting down a river. Tap left/right to nudge between gates, avoid hazards, and collect coins. Levels are short, escalating, and checkpointed.

## Core Loop

1. Start a level
2. Drift forward through gates and hazards
3. Collect coins and score multipliers
4. Reach checkpoint or fail
5. On fail: restart or watch a rewarded ad to continue from the last checkpoint
6. On completion: earn coins, unlock achievements, progress to the next level

## Controls

- Tap left/right: lateral nudge
- Later worlds: hold to reduce drift speed for precision play

## Session Length

- 2–5 minutes per session via short levels + fast retry + checkpointing.

## Difficulty Curve

- World 1: wide lanes, slow speed, forgiving obstacles
- World 2: narrower gates, mixed hazard cadence
- World 3: moving obstacles and timed gates
- World 4+: higher speed, layered patterns, mastery-driven scoring

## Progression

- Levels grouped into Worlds (theme + mechanical twist)
- Persistent coins used for visual-only customization (skins, trails, UI themes)
- Achievements reward bonus coins and cosmetic milestones

## Monetization (Ads Only)

- Rewarded ads
  - continue after fail (limited per run)
  - optional bonus coins after level completion
- Interstitials
  - only after every 3 completed levels
  - cooldown (minimum 5 minutes)
  - remote-config controlled and user opt-out after first impression

