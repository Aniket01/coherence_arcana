import 'package:coherence_arcana/audio/audio_controller.dart';
import 'package:coherence_arcana/audio/sounds.dart';
import 'package:coherence_arcana/game_theme.dart';
import 'package:coherence_arcana/routes.dart';
import 'package:coherence_arcana/style/responsive_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class MainMenuView extends StatelessWidget {
  const MainMenuView({super.key});

  @override
  Widget build(BuildContext context) {
    final audioController = Provider.of<AudioController>(
      context,
      listen: false,
    );

    return Scaffold(
      backgroundColor: backgroundColor,
      body: ResponsiveScreen(
        squarishMainArea: Center(
          child: Transform.rotate(
            angle: -0.1,
            child: Text(
              'Coherence Arcana',
              textAlign: TextAlign.center,
              style: GoogleFonts.pressStart2p(fontSize: 44, height: 1),
            ),
          ),
        ),
        rectangularMenuArea: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            ElevatedButton(
              onPressed: () {
                audioController.playSfx(SfxType.buttonClick);
                Navigator.of(context).pushNamed(levelSelectionRoute);
              },
              child: Text('Play'),
            ),
            _gap,
            ElevatedButton(
              onPressed: () {
                audioController.playSfx(SfxType.buttonClick);
                Navigator.of(context).pushNamed(tutorial);
              },
              child: Text('Tutorial'),
            ),
            _gap,
          ],
        ),
      ),
    );
  }

  static const _gap = SizedBox(height: 10);
}
