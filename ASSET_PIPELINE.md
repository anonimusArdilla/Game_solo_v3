# Asset Pipeline

## Naming

- Audio
  - `assets/audio/bgm_*.wav`
  - `assets/audio/sfx_*.wav`
- Fonts
  - `assets/fonts/NotoSans-*.ttf`
  - `assets/fonts/NotoSansCJK*.otf`

## Audio

- BGM: loop-safe segments, streamed via `FlameAudio.bgm`
- SFX: short, mono where possible, played via `FlameAudio.play`

## Fonts

- Latin base: Noto Sans
- CJK: Noto Sans CJK (SC/JP/KR)
- Thai: Noto Sans Thai
- Loaded via `FontLoader` through `FontManager`

