import 'package:coherence_arcana/widgets/game_theme.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:coherence_arcana/widgets/tutorial_page.dart';

/// A full-screen tutorial view that uses a carousel.
class TutorialView extends StatefulWidget {
  const TutorialView({super.key});

  @override
  State<TutorialView> createState() => _TutorialViewState();
}

class _TutorialViewState extends State<TutorialView> {
  // State variable to track the current page
  int _current = 0;

  // Controller for the carousel
  final CarouselSliderController _controller = CarouselSliderController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: SafeArea(
        child: Column(
          // Center the carousel and dots vertically
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // --- Carousel Slider ---
            CarouselSlider.builder(
              itemCount: tutorialData.length,
              carouselController: _controller,
              options: CarouselOptions(
                // Set height to a large fraction of the screen
                height: MediaQuery.of(context).size.height * 0.75,
                // Each page fills the full width
                viewportFraction: 1.0,
                // Tutorial shouldn't loop
                enableInfiniteScroll: false,
                // Don't auto-play
                autoPlay: false,
                // Update the current page index
                onPageChanged: (index, reason) {
                  setState(() {
                    _current = index;
                  });
                },
              ),
              itemBuilder: (context, index, realIndex) {
                final item = tutorialData[index];

                // --- Page Item Layout ---
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Image
                    Image.asset(
                      item.imagePath,
                      height: 300,
                      // Add an error builder for robustness
                      errorBuilder: (context, error, stackTrace) {
                        return const Icon(
                          Icons.image_not_supported,
                          size: 300,
                          color: Colors.grey,
                        );
                      },
                    ),
                    const SizedBox(height: 40),

                    // Title
                    Text(
                      item.title,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 20),

                    // Description
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: Text(
                        item.description,
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 12, color: Colors.grey[700]),
                        softWrap: true,
                      ),
                    ),
                  ],
                );
              },
            ),

            // --- Page Indicator Dots ---
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: tutorialData.asMap().entries.map((entry) {
                int index = entry.key;
                return GestureDetector(
                  // Allow tapping on a dot to jump to that page
                  onTap: () => _controller.animateToPage(index),
                  child: Container(
                    width: _current == index ? 12.0 : 8.0,
                    height: _current == index ? 12.0 : 8.0,
                    margin: const EdgeInsets.symmetric(
                      vertical: 8.0,
                      horizontal: 4.0,
                    ),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      // Active dot is darker, inactive is lighter
                      color: (Theme.of(context).brightness == Brightness.dark
                          ? Colors.white
                          : Colors.black),
                    ),
                  ),
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }
}
