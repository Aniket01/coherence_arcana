import 'dart:math';

import 'package:audioplayers/audioplayers.dart';
import 'songs.dart';
import 'sounds.dart';
import 'package:flutter/foundation.dart'; // For ChangeNotifier

/// Manages all music and sound effects playback for the game.
class AudioController extends ChangeNotifier {
  // --- State ---
  bool _musicOn = true;
  bool _sfxOn = true;
  bool _isInitialized = false;
  final Random _random = Random();

  // --- Audio Players ---

  /// Player for background music.
  final AudioPlayer _musicPlayer = AudioPlayer(playerId: 'musicPlayer');

  /// Pool of players for sound effects to allow overlapping sounds.
  final List<AudioPlayer> _sfxPlayers = [];
  final int _sfxPlayerPoolSize = 5; // Can play 5 sounds simultaneously
  int _currentSfxPlayer = 0;

  /// Cache for sound effects for faster playback.
  /// We assume SFX are in 'assets/sfx/'.
  final AudioCache _sfxCache = AudioCache(prefix: 'assets/sfx/');

  /// Cache for music.
  /// We assume music is in 'assets/music/'.
  final AudioCache _musicCache = AudioCache(prefix: 'assets/music/');

  // --- Getters ---

  /// Whether music is currently enabled.
  bool get isMusicOn => _musicOn;

  /// Whether sound effects are currently enabled.
  bool get isSfxOn => _sfxOn;

  // --- Initialization ---

  /// Initializes the audio controller.
  /// This must be called before playing any audio.
  Future<void> initialize() async {
    if (_isInitialized) return;

    _isInitialized = true;
    debugPrint('Initializing AudioController...');

    // Configure the audio session for the entire app.
    // This is crucial for allowing music and sound effects to play simultaneously.
    try {
      await AudioPlayer.global.setAudioContext(
        AudioContext(
          iOS: AudioContextIOS(
            category: AVAudioSessionCategory.ambient,
            options: const <AVAudioSessionOptions>{
              AVAudioSessionOptions.mixWithOthers,
            },
          ),
          android: const AudioContextAndroid(
            usageType: AndroidUsageType.game,
            contentType: AndroidContentType.music,
            audioFocus: AndroidAudioFocus.gainTransientMayDuck,
          ),
        ),
      );
    } catch (e) {
      debugPrint('Error setting audio context: $e');
    }

    // Set release mode to loop for the music player
    await _musicPlayer.setReleaseMode(ReleaseMode.loop);

    // Initialize the SFX player pool
    for (int i = 0; i < _sfxPlayerPoolSize; i++) {
      final player = AudioPlayer(playerId: 'sfxPlayer_$i');
      // Set release mode to stop, as SFX are one-shot
      await player.setReleaseMode(ReleaseMode.stop);
      _sfxPlayers.add(player);
    }

    // Pre-load (cache) all music and sfx files
    // This makes playback much faster.
    try {
      await _musicCache.loadAll(songs.map((song) => song.filename).toList());
      debugPrint('Music files cached.');

      // Get all unique sfx filenames
      final allSfxFiles = <String>{};
      for (final type in SfxType.values) {
        allSfxFiles.addAll(soundTypeToFilename(type));
      }
      await _sfxCache.loadAll(allSfxFiles.toList());
      debugPrint('SFX files cached.');
    } catch (e) {
      // Log the error
      debugPrint('Error caching audio files: $e');
      // Continue even if caching fails, playback might still work (but slower)
    }

    _isInitialized = true;
    debugPrint('AudioController initialized.');
  }

  // --- Music Control ---

  /// Starts playing a random background song if music is enabled.
  void playMusic() {
    if (!_musicOn ||
        !_isInitialized ||
        _musicPlayer.state == PlayerState.playing) {
      return;
    }

    // Pick a random song
    final song = songs.elementAt(_random.nextInt(songs.length));

    debugPrint('Playing music: ${song.filename}');
    // Play from the cache using AssetSource
    _musicPlayer.play(AssetSource('music/${song.filename}'), volume: 0.7);
  }

  /// Toggles the music on or off.
  void toggleMusic() {
    _musicOn = !_musicOn;
    if (_musicOn) {
      playMusic(); // Start music if it was off
    } else {
      _musicPlayer.pause(); // Pause music if it was on
    }
    notifyListeners();
  }

  /// Stops the music playback.
  void stopMusic() {
    _musicPlayer.stop();
  }

  // --- SFX Control ---

  /// Plays a sound effect of the given type if SFX are enabled.
  void playSfx(SfxType type) {
    if (!_sfxOn || !_isInitialized) {
      return;
    }

    // Get the list of possible filenames for this SFX type
    final filenames = soundTypeToFilename(type);
    if (filenames.isEmpty) {
      return;
    }

    // Pick a random filename from the list
    final filename = filenames[_random.nextInt(filenames.length)];

    // Get the volume for this SFX type
    final volume = soundTypeToVolume(type);

    // Get the next available SFX player from the pool (round-robin)
    final player = _sfxPlayers[_currentSfxPlayer];
    _currentSfxPlayer = (_currentSfxPlayer + 1) % _sfxPlayerPoolSize;

    // Play the sound from the cache
    debugPrint('Playing SFX: $filename at volume $volume');
    player.play(AssetSource('sfx/$filename'), volume: volume);
  }

  /// Toggles sound effects on or off.
  void toggleSfx() {
    _sfxOn = !_sfxOn;
    notifyListeners();
  }

  // --- Lifecycle ---

  /// Disposes of all audio players when the controller is no longer needed.
  @override
  void dispose() {
    _musicPlayer.dispose();
    for (final player in _sfxPlayers) {
      player.dispose();
    }
    super.dispose();
  }
}
