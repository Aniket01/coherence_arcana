import 'package:flutter/material.dart'; // For Icons
import 'card_data.dart';
import 'game_theme.dart'; // To get card colors
import 'level_data.dart';

// This is the Level 4 data, extracted from the original game file.
final LevelData level4 = LevelData(
  // Level properties
  levelNumber: 4,
  boardRows: 3,
  boardCols: 6,
  playerHandSize: 12,
  utilitySlotCount: 4,
  maxDecoherence: 30.0,
  decoherencePerAction: 2.0,

  // Initial Utility & Artifacts slots
  initialUtilitySlots: <CardData?>[
    CardData(
      id: 'filter-card',
      symbol: 'FILTER',
      cornerIconTopLeft: Icons.tune,
      cornerIconBottomRight: Icons.timer,
      cardColor: cardColor, // From game_theme.dart
      symbolColor: symbolColor, // From game_theme.dart
    ),
    CardData(
      id: 'potion-card',
      symbol: 'POTION',
      cornerIconTopLeft: Icons.lightbulb_outline,
      cornerIconBottomRight: Icons.bolt,
      cardColor: cardColor,
      symbolColor: symbolColor,
    ),
    null, // Empty slot
    null, // Empty slot
  ],

  // Initial Board cells
  initialBoardCells: () {
    // Use a function to easily construct the 2D list
    var board = List<List<CardData?>>.generate(
      3, // boardRows
      (int row) => List<CardData?>.filled(6, null), // boardCols
    );
    // Populate initial board cells
    board[0][0] = CardData(
      id: 'psi-card-00',
      symbol: '|ψ⟩',
      cornerIconTopLeft: Icons.schedule,
      cornerIconBottomRight: Icons.schedule,
      cardColor: cardColor,
      symbolColor: symbolColor,
    );
    board[0][3] = CardData(
      id: 'h-card-03',
      symbol: 'H',
      cornerIconTopLeft: Icons.settings_input_component,
      cornerIconBottomRight: Icons.settings_input_component,
      cardColor: cardColor,
      symbolColor: symbolColor,
    );
    board[1][0] = CardData(
      id: 'zero-card-10',
      symbol: '|0⟩',
      cornerIconTopLeft: Icons.schedule,
      cornerIconBottomRight: Icons.schedule,
      cardColor: cardColor,
      symbolColor: symbolColor,
    );
    board[1][1] = CardData(
      id: 'h-card-11',
      symbol: 'H',
      cornerIconTopLeft: Icons.settings_input_component,
      cornerIconBottomRight: Icons.settings_input_component,
      cardColor: cardColor,
      symbolColor: symbolColor,
    );
    board[1][3] = CardData(
      id: 'cnot-card-13',
      symbol: 'CNOT',
      cornerIconTopLeft: Icons.settings_input_component,
      cornerIconBottomRight: Icons.settings_input_component,
      cardColor: cardColor,
      symbolColor: symbolColor,
    );
    board[2][0] = CardData(
      id: 'zero-card-20',
      symbol: '|0⟩',
      cornerIconTopLeft: Icons.schedule,
      cornerIconBottomRight: Icons.schedule,
      cardColor: cardColor,
      symbolColor: symbolColor,
    );
    board[2][3] = CardData(
      id: 'x-card-23',
      symbol: 'X',
      cornerIconTopLeft: Icons.settings_input_component,
      cornerIconBottomRight: Icons.settings_input_component,
      cardColor: cardColor,
      symbolColor: symbolColor,
    );
    board[2][4] = CardData(
      id: 'z-card-24',
      symbol: 'Z',
      cornerIconTopLeft: Icons.settings_input_component,
      cornerIconBottomRight: Icons.settings_input_component,
      cardColor: cardColor,
      symbolColor: symbolColor,
    );
    return board;
  }(),

  // Initial Player Hand
  initialPlayerHand: () {
    var hand = <CardData?>[
      CardData(
        id: 'one-hand',
        symbol: '|1⟩',
        cornerIconTopLeft: Icons.schedule,
        cornerIconBottomRight: Icons.schedule,
        cardColor: cardColor,
        symbolColor: symbolColor,
      ),
      CardData(
        id: 'zero-hand',
        symbol: '|0⟩',
        cornerIconTopLeft: Icons.schedule,
        cornerIconBottomRight: Icons.schedule,
        cardColor: cardColor,
        symbolColor: symbolColor,
      ),
      CardData(
        id: 'p-hand',
        symbol: 'P',
        cornerIconTopLeft: Icons.settings_input_component,
        cornerIconBottomRight: Icons.settings_input_component,
        cardColor: cardColor,
        symbolColor: symbolColor,
      ),
      CardData(
        id: 'cnot-hand',
        symbol: 'CNOT',
        cornerIconTopLeft: Icons.settings_input_component,
        cornerIconBottomRight: Icons.settings_input_component,
        cardColor: cardColor,
        symbolColor: symbolColor,
      ),
      CardData(
        id: 'decohered-hand',
        symbol: 'DECOHERED',
        cornerIconTopLeft: Icons.blur_on,
        cornerIconBottomRight: Icons.scatter_plot,
        cardColor: cardColor,
        symbolColor: symbolColor,
      ),
    ];
    // Pad the hand with nulls up to the playerHandSize
    while (hand.length < 12) {
      // playerHandSize
      hand.add(null);
    }
    return hand;
  }(),
);
