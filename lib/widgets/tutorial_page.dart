// A simple data model for tutorial pages

class TutorialPage {
  final String imagePath;
  final String title;
  final String description;

  TutorialPage({
    required this.imagePath,
    required this.title,
    required this.description,
  });
}

// Data for the tutorial pages
final List<TutorialPage> tutorialData = [
  TutorialPage(
    imagePath: 'assets/images/large.png',
    title: 'Welcome to Coherence Arcana!🎮',
    description:
        'Recreate fleeting glimpses of quantum circuits before decoherence takes over. Drag, drop, and measure — but act wisely, or the universe resets.',
  ),
  TutorialPage(
    imagePath: 'assets/images/tutorial_2.png',
    title: '🧩 Memorize & Recreate',
    description:
        "Coherence Arcana challenges your memory, logic, and precision. You'll be briefly shown a quantum circuit, then tasked with rebuilding it from memory using draggable cards. Each move adds to your Decoherence Meter — if it fills up, the circuit collapses and you must start over.",
  ),
  TutorialPage(
    imagePath: 'assets/images/tutorial_3.png',
    title: '✨ Use Artifacts Wisely',
    description:
        'Use Artifact Cards wisely to undo mistakes, remove clutter, or stabilize the circuit — but beware: every artifact costs you 10 points. Your final score depends on how efficiently you reconstruct and measure the correct circuit before coherence fades.',
  ),
  TutorialPage(
    imagePath: 'assets/images/tutorial_4.png',
    title: '🧮 Scoring Rules',
    description:
        '✅ Correct circuit measured: +100 pts\n❌ Wrong circuit: 0 pts\n🔄 Extra moves: –5 pts each\n🪄 Artifact used: –10 pts each\n🃏 Unused cards in hand: –5 pts each\nRecreate efficiently. Every move matters!',
  ),
];
