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
    imagePath: 'assets/images/tutorial_1.png',
    title: 'Welcome!',
    description: 'Explore all the features our app has to offer.',
  ),
  TutorialPage(
    imagePath: 'assets/images/tutorial_2.png',
    title: 'Create & Share',
    description: 'Easily create new projects and share them with your team.',
  ),
  TutorialPage(
    imagePath: 'assets/images/tutorial_3.png',
    title: 'Stay Organized',
    description: 'Keep all your tasks and notes in one organized place.',
  ),
];
