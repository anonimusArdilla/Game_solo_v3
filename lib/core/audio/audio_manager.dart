import 'package:flame_audio/flame_audio.dart';

import 'package:game_solo_v3/core/assets/assets.dart';

class AudioManager {
  AudioManager();

  double _musicVolume = 0.7;
  double _sfxVolume = 0.8;
  bool _muted = false;

  double get musicVolume => _musicVolume;
  double get sfxVolume => _sfxVolume;
  bool get muted => _muted;

  Future<void> preload() async {
    await FlameAudio.audioCache.loadAll([
      Assets.audioBgmLoop,
      Assets.audioSfxTap,
    ]);
  }

  Future<void> playBgm() async {
    if (_muted) {
      return;
    }
    await FlameAudio.bgm.stop();
    await FlameAudio.bgm.play(Assets.audioBgmLoop, volume: _musicVolume);
  }

  Future<void> stopBgm() async {
    await FlameAudio.bgm.stop();
  }

  void playTap() {
    if (_muted) {
      return;
    }
    FlameAudio.play(Assets.audioSfxTap, volume: _sfxVolume);
  }

  Future<void> setMuted({required bool muted}) async {
    _muted = muted;
    if (_muted) {
      await stopBgm();
    } else {
      await playBgm();
    }
  }

  Future<void> setMusicVolume(double value) async {
    _musicVolume = value.clamp(0.0, 1.0);
    if (_muted) {
      return;
    }
    FlameAudio.bgm.audioPlayer.setVolume(_musicVolume);
  }

  void setSfxVolume(double value) {
    _sfxVolume = value.clamp(0.0, 1.0);
  }
}

