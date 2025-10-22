import 'package:coherence_arcana/coherence_arcana_game.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'level_4.dart';
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
      home: CoherenceArcanaGame(levelData: level4),
    );
  }
}
