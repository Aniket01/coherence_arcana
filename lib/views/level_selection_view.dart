import 'package:coherence_arcana/routes.dart';
import 'package:coherence_arcana/views/pre_game_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../audio/audio_controller.dart';
import '../audio/sounds.dart';
import 'package:coherence_arcana/widgets/game_theme.dart';
import '../style/responsive_screen.dart';
import '../level_selection/levels.dart';
import 'package:google_fonts/google_fonts.dart';

class LevelSelectionScreen extends StatelessWidget {
  const LevelSelectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // final playerProgress = context.watch<PlayerProgress>();

    return Scaffold(
      backgroundColor: backgroundColor,
      body: ResponsiveScreen(
        squarishMainArea: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16),
              child: Center(
                child: Text(
                  'Select level',
                  style: GoogleFonts.pressStart2p().copyWith(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 50),
            Expanded(
              child: ListView(
                children: [
                  for (final level in gameLevels)
                    ListTile(
                      // enabled:
                      //     playerProgress.highestLevelReached >=
                      //     level.levelNumber - 1,
                      onTap: () {
                        final audioController = Provider.of<AudioController>(
                          context,
                          listen: false,
                        );
                        audioController.playSfx(SfxType.buttonClick);

                        // GoRouter.of(
                        //   context,
                        // ).go('/play/session/${level.levelNumber}');
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => PreGameView(
                              level: level.levelNumber - 1,
                            ), // levelNumber = level index - 1
                          ),
                        );
                      },
                      leading: Text(level.levelNumber.toString()),
                      title: Text('Level #${level.levelNumber}'),
                    ),
                ],
              ),
            ),
          ],
        ),
        rectangularMenuArea: IconButton(
          icon: BackButtonIcon(),
          onPressed: () {
            final audioController = Provider.of<AudioController>(
              context,
              listen: false,
            );
            audioController.playSfx(SfxType.cardNotPlaced);
            Navigator.of(context).popAndPushNamed(mainMenuRoute);
          },
        ),
      ),
    );
  }
}
