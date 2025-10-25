import 'package:flutter/material.dart'; // For Icons
import '../widgets/card_data.dart';
import '../widgets/game_theme.dart'; // To get card colors
import 'level_data.dart';

// This is the Level 4 data, extracted from the original game file.
final gameLevels = [
  LevelData(
    levelNumber: 1,
    boardRows: 1,
    boardCols: 6,
    playerHandSize: 8,
    utilitySlotCount: 4,
    maxDecoherence: 10,
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
        1, // boardRows
        (int row) => List<CardData?>.filled(6, null), //boardCols
      );
      board[0][0] = CardData(
        id: 'Qubit psi',
        symbol: '|ψ⟩',
        cardColor: cardColor,
        symbolColor: symbolColor,
      );
      board[0][1] = CardData(
        id: 'Qubit psi',
        symbol: '|ψ⟩',
        cardColor: cardColor,
        symbolColor: symbolColor,
      );
      board[0][2] = CardData(
        id: 'Qubit psi',
        symbol: '|ψ⟩',
        cardColor: cardColor,
        symbolColor: symbolColor,
      );
      board[0][3] = CardData(
        id: 'Qubit psi',
        symbol: '|ψ⟩',
        cardColor: cardColor,
        symbolColor: symbolColor,
      );
      board[0][4] = CardData(
        id: 'Qubit psi',
        symbol: '|ψ⟩',
        cardColor: cardColor,
        symbolColor: symbolColor,
      );
      board[0][5] = CardData(
        id: 'Qubit psi',
        symbol: '|ψ⟩',
        cardColor: cardColor,
        symbolColor: symbolColor,
      );
      return board;
    }(),
    initialPlayerHand: () {
      var hand = <CardData?>[
        CardData(
          id: 'Qubit 1',
          symbol: '|1⟩',
          cornerIconTopLeft: Icons.schedule,
          cornerIconBottomRight: Icons.schedule,
          cardColor: cardColor,
          symbolColor: symbolColor,
        ),
        CardData(
          id: 'Qubit 0',
          symbol: '|0⟩',
          cornerIconTopLeft: Icons.schedule,
          cornerIconBottomRight: Icons.schedule,
          cardColor: cardColor,
          symbolColor: symbolColor,
        ),
        CardData(
          id: 'Phase gate',
          symbol: 'P',
          cornerIconTopLeft: Icons.settings_input_component,
          cornerIconBottomRight: Icons.settings_input_component,
          cardColor: cardColor,
          symbolColor: symbolColor,
        ),
        CardData(
          id: 'CNOT gate',
          symbol: 'CNOT',
          cornerIconTopLeft: Icons.settings_input_component,
          cornerIconBottomRight: Icons.settings_input_component,
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
    boardCols: 6,
    playerHandSize: 8,
    utilitySlotCount: 4,
    maxDecoherence: 20,
    decoherencePerAction: 2.0,
    initialUtilitySlots: <CardData?>[
      CardData(
        id: 'Coherent qubit',
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
        (int row) => List<CardData?>.filled(6, null), //boardCols
      );
      board[0][0] = CardData(
        id: 'Qubit psi',
        symbol: '|ψ⟩',
        cardColor: cardColor,
        symbolColor: symbolColor,
      );
      board[0][1] = CardData(
        id: 'Qubit psi',
        symbol: '|ψ⟩',
        cardColor: cardColor,
        symbolColor: symbolColor,
      );
      board[0][2] = CardData(
        id: 'Qubit psi',
        symbol: '|ψ⟩',
        cardColor: cardColor,
        symbolColor: symbolColor,
      );
      board[0][3] = CardData(
        id: 'Qubit psi',
        symbol: '|ψ⟩',
        cardColor: cardColor,
        symbolColor: symbolColor,
      );
      board[0][4] = CardData(
        id: 'Qubit psi',
        symbol: '|ψ⟩',
        cardColor: cardColor,
        symbolColor: symbolColor,
      );
      board[0][5] = CardData(
        id: 'Qubit psi',
        symbol: '|ψ⟩',
        cardColor: cardColor,
        symbolColor: symbolColor,
      );
      return board;
    }(),
    initialPlayerHand: () {
      var hand = <CardData?>[
        CardData(
          id: 'Qubit 1',
          symbol: '|1⟩',
          cornerIconTopLeft: Icons.schedule,
          cornerIconBottomRight: Icons.schedule,
          cardColor: cardColor,
          symbolColor: symbolColor,
        ),
        CardData(
          id: 'Qubit 0',
          symbol: '|0⟩',
          cornerIconTopLeft: Icons.schedule,
          cornerIconBottomRight: Icons.schedule,
          cardColor: cardColor,
          symbolColor: symbolColor,
        ),
        CardData(
          id: 'Phase gate',
          symbol: 'P',
          cornerIconTopLeft: Icons.settings_input_component,
          cornerIconBottomRight: Icons.settings_input_component,
          cardColor: cardColor,
          symbolColor: symbolColor,
        ),
        CardData(
          id: 'CNOT gate',
          symbol: 'CNOT',
          cornerIconTopLeft: Icons.settings_input_component,
          cornerIconBottomRight: Icons.settings_input_component,
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
    boardRows: 2,
    boardCols: 6,
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
        id: 'Quantum Compass',
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
        (int row) => List<CardData?>.filled(6, null), //boardCols
      );
      board[0][0] = CardData(
        id: 'Qubit psi',
        symbol: '|ψ⟩',
        cardColor: cardColor,
        symbolColor: symbolColor,
      );
      board[0][1] = CardData(
        id: 'Qubit psi',
        symbol: '|ψ⟩',
        cardColor: cardColor,
        symbolColor: symbolColor,
      );
      board[0][2] = CardData(
        id: 'Qubit psi',
        symbol: '|ψ⟩',
        cardColor: cardColor,
        symbolColor: symbolColor,
      );
      board[0][3] = CardData(
        id: 'Qubit psi',
        symbol: '|ψ⟩',
        cardColor: cardColor,
        symbolColor: symbolColor,
      );
      board[0][4] = CardData(
        id: 'Qubit psi',
        symbol: '|ψ⟩',
        cardColor: cardColor,
        symbolColor: symbolColor,
      );
      board[0][5] = CardData(
        id: 'Qubit psi',
        symbol: '|ψ⟩',
        cardColor: cardColor,
        symbolColor: symbolColor,
      );
      return board;
    }(),
    initialPlayerHand: () {
      var hand = <CardData?>[
        CardData(
          id: 'Qubit 1',
          symbol: '|1⟩',
          cornerIconTopLeft: Icons.schedule,
          cornerIconBottomRight: Icons.schedule,
          cardColor: cardColor,
          symbolColor: symbolColor,
        ),
        CardData(
          id: 'Qubit 0',
          symbol: '|0⟩',
          cornerIconTopLeft: Icons.schedule,
          cornerIconBottomRight: Icons.schedule,
          cardColor: cardColor,
          symbolColor: symbolColor,
        ),
        CardData(
          id: 'Phase gate',
          symbol: 'P',
          cornerIconTopLeft: Icons.settings_input_component,
          cornerIconBottomRight: Icons.settings_input_component,
          cardColor: cardColor,
          symbolColor: symbolColor,
        ),
        CardData(
          id: 'CNOT gate',
          symbol: 'CNOT',
          cornerIconTopLeft: Icons.settings_input_component,
          cornerIconBottomRight: Icons.settings_input_component,
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
    boardRows: 3,
    boardCols: 6,
    playerHandSize: 12,
    utilitySlotCount: 4,
    maxDecoherence: 30.0,
    decoherencePerAction: 2.0,

    // Initial Utility & Artifacts slots
    initialUtilitySlots: <CardData?>[
      CardData(
        id: 'Noise Filter',
        symbol: 'FILTER',
        cornerIconTopLeft: Icons.tune,
        cornerIconBottomRight: Icons.timer,
        cardColor: cardColor, // From game_theme.dart
        symbolColor: symbolColor, // From game_theme.dart
      ),
      CardData(
        id: 'Quantum Compass',
        symbol: 'Artifact',
        cornerIconTopLeft: Icons.lightbulb_outline,
        cornerIconBottomRight: Icons.bolt,
        cardColor: cardColor,
        symbolColor: symbolColor,
      ),
      CardData(
        id: 'Coherent qubit',
        symbol: 'Artifact',
        cardColor: cardColor,
        symbolColor: symbolColor,
      ), // Empty slot
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
        id: 'Qubit psi',
        symbol: '|ψ⟩',
        cornerIconTopLeft: Icons.schedule,
        cornerIconBottomRight: Icons.schedule,
        cardColor: cardColor,
        symbolColor: symbolColor,
      );
      board[0][3] = CardData(
        id: 'Hadamard gate',
        symbol: 'H',
        cornerIconTopLeft: Icons.settings_input_component,
        cornerIconBottomRight: Icons.settings_input_component,
        cardColor: cardColor,
        symbolColor: symbolColor,
      );
      board[1][0] = CardData(
        id: 'Qubit 0',
        symbol: '|0⟩',
        cornerIconTopLeft: Icons.schedule,
        cornerIconBottomRight: Icons.schedule,
        cardColor: cardColor,
        symbolColor: symbolColor,
      );
      board[1][1] = CardData(
        id: 'Hadamard gate',
        symbol: 'H',
        cornerIconTopLeft: Icons.settings_input_component,
        cornerIconBottomRight: Icons.settings_input_component,
        cardColor: cardColor,
        symbolColor: symbolColor,
      );
      board[1][3] = CardData(
        id: 'CNOT gate',
        symbol: 'CNOT',
        cornerIconTopLeft: Icons.settings_input_component,
        cornerIconBottomRight: Icons.settings_input_component,
        cardColor: cardColor,
        symbolColor: symbolColor,
      );
      board[2][0] = CardData(
        id: 'Qubit 0',
        symbol: '|0⟩',
        cornerIconTopLeft: Icons.schedule,
        cornerIconBottomRight: Icons.schedule,
        cardColor: cardColor,
        symbolColor: symbolColor,
      );
      board[2][2] = CardData(
        id: 'CNOT gate',
        symbol: 'X',
        cornerIconTopLeft: Icons.settings_input_component,
        cornerIconBottomRight: Icons.settings_input_component,
        cardColor: cardColor,
        symbolColor: symbolColor,
      );
      board[2][3] = CardData(
        id: 'X gate',
        symbol: 'X',
        cornerIconTopLeft: Icons.settings_input_component,
        cornerIconBottomRight: Icons.settings_input_component,
        cardColor: cardColor,
        symbolColor: symbolColor,
      );
      board[2][4] = CardData(
        id: 'Z gate',
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
          id: 'Qubit 1',
          symbol: '|1⟩',
          cornerIconTopLeft: Icons.schedule,
          cornerIconBottomRight: Icons.schedule,
          cardColor: cardColor,
          symbolColor: symbolColor,
        ),
        CardData(
          id: 'Qubit 0',
          symbol: '|0⟩',
          cornerIconTopLeft: Icons.schedule,
          cornerIconBottomRight: Icons.schedule,
          cardColor: cardColor,
          symbolColor: symbolColor,
        ),
        CardData(
          id: 'Phase gate',
          symbol: 'P',
          cornerIconTopLeft: Icons.settings_input_component,
          cornerIconBottomRight: Icons.settings_input_component,
          cardColor: cardColor,
          symbolColor: symbolColor,
        ),
        CardData(
          id: 'CNOT gate',
          symbol: 'CNOT',
          cornerIconTopLeft: Icons.settings_input_component,
          cornerIconBottomRight: Icons.settings_input_component,
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
