// A reusable widget for displaying a single game card.
import 'package:coherence_arcana/card_data.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

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
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: isEmpty ? _emptySlotBackgroundColor : cardData.cardColor,
        borderRadius: BorderRadius.circular(8.0),
        border: Border.all(color: cardBorderColor, width: 2.0),
      ),
      child: isEmpty
          ? null // No content for empty slots.
          : Stack(
              children: <Widget>[
                // Corner icons
                if (cardData.cornerIconTopLeft != null)
                  Positioned(
                    top: 4.0,
                    left: 4.0,
                    child: Icon(
                      cardData.cornerIconTopLeft,
                      color: cardData.symbolColor,
                      size: 16.0,
                    ),
                  ),
                if (cardData.cornerIconBottomRight != null)
                  Positioned(
                    bottom: 4.0,
                    right: 4.0,
                    child: Icon(
                      cardData.cornerIconBottomRight,
                      color: cardData.symbolColor,
                      size: 16.0,
                    ),
                  ),
                // Main symbol
                Center(
                  child: Text(
                    cardData.symbol,
                    style: GoogleFonts.getFont('Press Start 2P').copyWith(
                      color: cardData.symbolColor,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
    );
  }
}
