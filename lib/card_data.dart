import 'package:flutter/material.dart';

// CardData model represents the information for each card in the game.
class CardData {
  final String id; // Unique identifier for each card instance.
  final String symbol; // The main text/symbol displayed on the card.
  final IconData? cornerIconTopLeft; // Optional icon for the top-left corner.
  final IconData?
  cornerIconBottomRight; // Optional icon for the bottom-right corner.
  final Color cardColor; // The background color of the card.
  final Color symbolColor; // The color of the symbol text.

  CardData({
    required this.id,
    required this.symbol,
    this.cornerIconTopLeft,
    this.cornerIconBottomRight,
    required this.cardColor,
    required this.symbolColor,
  });

  // Factory constructor for creating an empty slot card.
  factory CardData.empty({
    required Color cardColor,
    required Color symbolColor,
  }) {
    return CardData(
      id: 'empty-${DateTime.now().microsecondsSinceEpoch}',
      symbol: '',
      cardColor: cardColor,
      symbolColor: symbolColor,
    );
  }
}
