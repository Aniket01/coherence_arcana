import 'package:flutter/material.dart'; // For Icons
import '../widgets/card_data.dart';
import '../widgets/game_theme.dart'; // To get card colors
import 'level_data.dart';

// This is the Level 4 data, extracted from the original game file.
final gameLevels = [
  LevelData(
    levelNumber: 1,
    boardRows: 2,
    boardCols: 3,
    playerHandSize: 9,
    utilitySlotCount: 4,
    maxDecoherence: 16,
    decoherencePerAction: 2.0,
    initialUtilitySlots: <CardData?>[
      CardData(
        id: 'Stabilizer',
        symbol: 'Artifact',
        cardColor: cardColor,
        symbolColor: symbolColor,
      ),
      null,
      null,
      null,
    ],
    initialBoardCells: () {
      var board = List<List<CardData?>>.generate(
        2, // boardRows
        (int row) => List<CardData?>.filled(3, null), //boardCols
      );
      return board;
    }(),
    initialPlayerHand: () {
      var hand = <CardData?>[
        CardData(
          id: 'Qubit 0',
          symbol: '|0⟩',
          cardColor: cardColor,
          symbolColor: symbolColor,
        ),
        CardData(
          id: 'Qubit phi',
          symbol: '|0⟩',
          cardColor: cardColor,
          symbolColor: symbolColor,
        ),
        CardData(
          id: 'Qubit 0',
          symbol: '|0⟩',
          cardColor: cardColor,
          symbolColor: symbolColor,
        ),
        CardData(
          id: 'X gate',
          symbol: 'X',
          cardColor: cardColor,
          symbolColor: symbolColor,
        ),
        CardData(
          id: 'target up',
          symbol: 'CNOT',
          cardColor: cardColor,
          symbolColor: symbolColor,
        ),
        CardData(
          id: 'Hadamard gate',
          symbol: 'H',
          cardColor: cardColor,
          symbolColor: symbolColor,
        ),
        CardData(
          id: 'target down',
          symbol: 'CNOT',
          cardColor: cardColor,
          symbolColor: symbolColor,
        ),
        CardData(
          id: 'control up',
          symbol: 'CNOT',
          cardColor: cardColor,
          symbolColor: symbolColor,
        ),
        CardData(
          id: 'control down',
          symbol: 'CNOT',
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
  ),
  LevelData(
    levelNumber: 2,
    boardRows: 2,
    boardCols: 4,
    playerHandSize: 10,
    utilitySlotCount: 4,
    maxDecoherence: 24,
    decoherencePerAction: 2.0,
    initialUtilitySlots: <CardData?>[
      CardData(
        id: 'Coherent qubit',
        symbol: 'Artifact',
        cardColor: cardColor,
        symbolColor: symbolColor,
      ),
      CardData(
        id: 'Stabilizer',
        symbol: 'Artifact',
        cardColor: cardColor,
        symbolColor: symbolColor,
      ),
      null,
      null,
    ],
    initialBoardCells: () {
      var board = List<List<CardData?>>.generate(
        2, // boardRows
        (int row) => List<CardData?>.filled(4, null), //boardCols
      );
      return board;
    }(),
    initialPlayerHand: () {
      var hand = <CardData?>[
        CardData(
          id: 'control up',
          symbol: 'CNOT',
          cardColor: cardColor,
          symbolColor: symbolColor,
        ),
        CardData(
          id: 'Qubit psi',
          symbol: '|0⟩',
          cardColor: cardColor,
          symbolColor: symbolColor,
        ),
        CardData(
          id: 'Phase gate',
          symbol: 'P',
          cardColor: cardColor,
          symbolColor: symbolColor,
        ),
        CardData(
          id: 'target up',
          symbol: 'CNOT',
          cardColor: cardColor,
          symbolColor: symbolColor,
        ),
        CardData(
          id: 'X gate',
          symbol: 'X',
          cardColor: cardColor,
          symbolColor: symbolColor,
        ),
        CardData(
          id: 'target up',
          symbol: 'CNOT',
          cardColor: cardColor,
          symbolColor: symbolColor,
        ),
        CardData(
          id: 'control down',
          symbol: 'CNOT',
          cardColor: cardColor,
          symbolColor: symbolColor,
        ),
        CardData(
          id: 'control down',
          symbol: 'CNOT',
          cardColor: cardColor,
          symbolColor: symbolColor,
        ),
        CardData(
          id: 'Qubit phi',
          symbol: '|0⟩',
          cardColor: cardColor,
          symbolColor: symbolColor,
        ),
        CardData(
          id: 'target down',
          symbol: 'CNOT',
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
  ),
  LevelData(
    levelNumber: 3,
    boardRows: 3,
    boardCols: 4,
    playerHandSize: 12,
    utilitySlotCount: 4,
    maxDecoherence: 24,
    decoherencePerAction: 2.0,
    initialUtilitySlots: <CardData?>[
      CardData(
        id: 'Stabilizer',
        symbol: 'Artifact',
        cardColor: cardColor,
        symbolColor: symbolColor,
      ),
      CardData(
        id: 'Noise Filter',
        symbol: 'Artifact',
        cardColor: cardColor,
        symbolColor: symbolColor,
      ),
      null,
      null,
    ],
    initialBoardCells: () {
      var board = List<List<CardData?>>.generate(
        3, // boardRows
        (int row) => List<CardData?>.filled(4, null), //boardCols
      );
      return board;
    }(),
    initialPlayerHand: () {
      var hand = <CardData?>[
        CardData(
          id: 'Hadamard gate',
          symbol: 'H',
          cardColor: cardColor,
          symbolColor: symbolColor,
        ),
        CardData(
          id: 'Qubit 0',
          symbol: '|0⟩',
          cardColor: cardColor,
          symbolColor: symbolColor,
        ),
        CardData(
          id: 'Z gate',
          symbol: 'Z',
          cardColor: cardColor,
          symbolColor: symbolColor,
        ),
        CardData(
          id: 'control down',
          symbol: 'CNOT',
          cardColor: cardColor,
          symbolColor: symbolColor,
        ),
        CardData(
          id: 'Phase gate',
          symbol: 'P',
          cornerIconTopLeft: Icons.blur_on,
          cornerIconBottomRight: Icons.scatter_plot,
          cardColor: cardColor,
          symbolColor: symbolColor,
        ),
        CardData(
          id: 'control up',
          symbol: 'CNOT',
          cardColor: cardColor,
          symbolColor: symbolColor,
        ),
        CardData(
          id: 'target up',
          symbol: 'CNOT',
          cardColor: cardColor,
          symbolColor: symbolColor,
        ),
        CardData(
          id: 'Qubit 0',
          symbol: '|0⟩',
          cardColor: cardColor,
          symbolColor: symbolColor,
        ),
        CardData(
          id: 'Qubit 0',
          symbol: '|0⟩',
          cardColor: cardColor,
          symbolColor: symbolColor,
        ),
        CardData(
          id: 'control down',
          symbol: 'CNOT',
          cardColor: cardColor,
          symbolColor: symbolColor,
        ),
        CardData(
          id: 'target up',
          symbol: 'CNOT',
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
  ),
  LevelData(
    // Level 4 properties
    levelNumber: 4,
    boardRows: 2,
    boardCols: 7,
    playerHandSize: 12,
    utilitySlotCount: 4,
    maxDecoherence: 30.0,
    decoherencePerAction: 2.0,

    // Initial Utility & Artifacts slots
    initialUtilitySlots: <CardData?>[
      CardData(
        id: 'Noise Filter',
        symbol: 'FILTER',
        cardColor: cardColor,
        symbolColor: symbolColor,
      ),
      CardData(
        id: 'Stabilizer',
        symbol: 'Artifact',
        cardColor: cardColor,
        symbolColor: symbolColor,
      ),
      CardData(
        id: 'Coherent qubit',
        symbol: 'Artifact',
        cardColor: cardColor,
        symbolColor: symbolColor,
      ),
      null, // Empty slot
    ],

    // Initial Board cells
    initialBoardCells: () {
      // Use a function to easily construct the 2D list
      var board = List<List<CardData?>>.generate(
        2, // boardRows
        (int row) => List<CardData?>.filled(7, null), // boardCols
      );
      return board;
    }(),

    // Initial Player Hand
    initialPlayerHand: () {
      var hand = <CardData?>[
        CardData(
          id: 'Qubit',
          symbol: '|Q⟩',
          cardColor: cardColor,
          symbolColor: symbolColor,
        ),
        CardData(
          id: 'Qubit',
          symbol: '|Q⟩',
          cardColor: cardColor,
          symbolColor: symbolColor,
        ),
        CardData(
          id: 'Phase gate',
          symbol: 'P',
          cardColor: cardColor,
          symbolColor: symbolColor,
        ),
        CardData(
          id: 'target up',
          symbol: 'CNOT',
          cardColor: cardColor,
          symbolColor: symbolColor,
        ),
        CardData(
          id: 'Hadamard gate',
          symbol: 'H',
          cardColor: cardColor,
          symbolColor: symbolColor,
        ),
        CardData(
          id: 'Hadamard gate',
          symbol: 'H',
          cardColor: cardColor,
          symbolColor: symbolColor,
        ),
        CardData(
          id: 'Z gate',
          symbol: 'Z',
          cardColor: cardColor,
          symbolColor: symbolColor,
        ),
        CardData(
          id: 'target up',
          symbol: 'CNOT',
          cardColor: cardColor,
          symbolColor: symbolColor,
        ),
        CardData(
          id: 'control down',
          symbol: 'CNOT',
          cardColor: cardColor,
          symbolColor: symbolColor,
        ),
        CardData(
          id: 'X gate',
          symbol: 'X',
          cardColor: cardColor,
          symbolColor: symbolColor,
        ),
        CardData(
          id: 'control down',
          symbol: 'CNOT',
          cardColor: cardColor,
          symbolColor: symbolColor,
        ),
        CardData(
          id: 'Hadamard gate',
          symbol: 'H',
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
  ),
];
