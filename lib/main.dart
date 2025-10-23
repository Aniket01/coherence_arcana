import 'package:coherence_arcana/coherence_arcana_game.dart';
import 'package:coherence_arcana/level_selection/level_selection_view.dart';
import 'package:coherence_arcana/main_menu_view.dart';
import 'package:coherence_arcana/routes.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../audio/audio_controller.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    ChangeNotifierProvider(
      create: (context) => AudioController(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Coherence Arcana',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
        textTheme: GoogleFonts.getTextTheme(
          'Press Start 2P',
          Theme.of(context).textTheme,
        ),
      ),
      home: MainMenuView(),
      routes: {
        levelSelectionRoute: (context) => const LevelSelectionScreen(),
        mainMenuRoute: (context) => const MainMenuView(),
        gameRoute: (context) => const CoherenceArcanaGame(),
      },
    );
  }
}
