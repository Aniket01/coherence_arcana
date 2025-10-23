// A reusable widget for displaying a single game card.
import 'package:coherence_arcana/widgets/card_data.dart';
import 'package:flutter/material.dart';

const Color _emptySlotBackgroundColor = Color(
  0x33F9C07F,
); // Transparent version of card border for empty slots

class GameCard extends StatelessWidget {
  final CardData cardData;
  final Color cardBorderColor;
  final bool isEmpty;
  final double width;
  final double height;

  const GameCard({
    super.key,
    required this.cardData,
    required this.cardBorderColor,
    this.isEmpty = false,
    required this.width,
    required this.height,
  });

  @override
  Widget build(BuildContext context) {
    // Construct the asset path from the card's ID.
    // Example: id 'psi-card' becomes 'assets/cards/psi-card.png'
    final String assetPath = 'assets/cards/${cardData.id}.png';

    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        // The image itself provides the background, so we make the
        // container transparent if it's not an empty slot.
        color: isEmpty ? _emptySlotBackgroundColor : Colors.transparent,
        borderRadius: BorderRadius.circular(8.0),
        border: Border.all(color: cardBorderColor, width: 2.0),
      ),
      child: isEmpty
          ? null // No content for empty slots.
          : ClipRRect(
              // Clip the image to the rounded corners,
              // slightly smaller than the container to fit inside the border.
              borderRadius: BorderRadius.circular(6.0),
              child: Image.asset(
                assetPath,
                width: width,
                height: height,
                // BoxFit.cover ensures the image fills the card space,
                // cropping if necessary, without distorting aspect ratio.
                fit: BoxFit.cover,
                // Add a simple error builder in case an asset is missing
                errorBuilder: (context, error, stackTrace) {
                  return const Center(
                    child: Icon(
                      Icons.broken_image,
                      color: Colors.red,
                      size: 24,
                    ),
                  );
                },
              ),
            ),
    );
  }
}
