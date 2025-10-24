import 'package:coherence_arcana/game_internals/score.dart';
import 'package:coherence_arcana/routes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../audio/audio_controller.dart';
import '../audio/sounds.dart';
import 'package:coherence_arcana/widgets/game_theme.dart';
import '../style/responsive_screen.dart';

class PostGameView extends StatelessWidget {
  const PostGameView({super.key, required this.scoreData, this.maxStars = 5});
  final int maxStars;
  final Score scoreData;

  @override
  Widget build(BuildContext context) {
    final int effectiveStars = scoreData.stars.clamp(0, maxStars);
    final audioController = Provider.of<AudioController>(
      context,
      listen: false,
    );
    final nextLvl = scoreData.level + 1;

    return Scaffold(
      backgroundColor: backgroundColor,
      body: ResponsiveScreen(
        squarishMainArea: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              'Game Over!',
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: Colors.blueAccent,
              ),
            ),
            const SizedBox(height: 20),
            Text(
              'Final Score: ${scoreData.score}',
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w600,
                color: Colors.deepPurple,
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'Your Rating:',
              style: TextStyle(fontSize: 20, color: Colors.grey),
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(maxStars, (index) {
                // Determine if the current star should be filled or outlined
                if (index < effectiveStars) {
                  return const Icon(Icons.star, color: Colors.amber, size: 40);
                } else {
                  return const Icon(
                    Icons.star_border,
                    color: Colors.grey,
                    size: 40,
                  );
                }
              }),
            ),
          ],
        ),
        rectangularMenuArea: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            ElevatedButton(
              onPressed: () {
                audioController.playSfx(SfxType.buttonClick);
                Navigator.of(
                  context,
                ).pushNamedAndRemoveUntil('/game$nextLvl/', (route) => false);
              },
              child: Text('Next Level'),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                audioController.playSfx(SfxType.buttonClick);
                Navigator.of(
                  context,
                ).pushNamedAndRemoveUntil(mainMenuRoute, (route) => false);
              },
              child: Text('Home'),
            ),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}
