import 'package:coherence_arcana/level_selection/levels.dart';
import 'package:coherence_arcana/views/coherence_arcana_game.dart';
import 'package:flutter/material.dart';
import 'dart:async'; // Required for Timer

class PreGameView extends StatefulWidget {
  const PreGameView({super.key, required this.level});
  final int level;
  @override
  State<PreGameView> createState() => _PreGameViewState();
}

class _PreGameViewState extends State<PreGameView> {
  // The initial countdown duration in seconds.
  int _countdownSeconds = 20;
  // Timer object to handle the periodic countdown.
  Timer? _timer;
  late final int _selectedLevelIndex;

  @override
  void initState() {
    super.initState();
    _selectedLevelIndex =
        (widget.level >= 0 && widget.level < gameLevels.length)
        ? widget.level
        : 0;
    _startCountdown();
  }

  /// Starts the countdown timer.
  ///
  /// The timer decreases `_countdownSeconds` every second.
  /// When `_countdownSeconds` reaches 0, it navigates to the `GameView`.
  void _startCountdown() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_countdownSeconds == 0) {
        // Stop the timer as the countdown has finished.
        _timer?.cancel();
        // Navigate to the GameView, replacing the current route.
        // This prevents the user from going back to the countdown screen.
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) =>
                CoherenceArcanaGame(levelData: gameLevels[_selectedLevelIndex]),
          ),
        );
      } else {
        // Update the UI with the new countdown value.
        setState(() {
          _countdownSeconds--;
        });
      }
    });
  }

  @override
  void dispose() {
    // IMPORTANT: Cancel the timer when the widget is disposed to prevent memory leaks.
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pre-Game Countdown'),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Game starting in...',
              style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.normal),
            ),
            const SizedBox(height: 20),
            // Display the current countdown seconds prominently.
            Text(
              '$_countdownSeconds',
              style: const TextStyle(
                fontSize: 72.0, // Large font for the countdown
                fontWeight: FontWeight.bold,
                color: Colors.deepPurple,
              ),
            ),
            const SizedBox(height: 20),
            const CircularProgressIndicator(), // Visual indicator of ongoing process
          ],
        ),
      ),
    );
  }
}
