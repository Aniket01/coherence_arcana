import 'package:coherence_arcana/board_card_slot.dart';
import 'package:coherence_arcana/game_button.dart';
import 'package:coherence_arcana/game_card.dart';
import 'package:coherence_arcana/hand_card_slot.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'card_data.dart';
import 'dart:math' as math;

import 'game_theme.dart'; // Import the new theme file
import 'level_data.dart'; // Import the new LevelData class

class CoherenceArcanaGame extends StatefulWidget {
  // The game now requires LevelData to be passed in.
  final LevelData levelData;

  const CoherenceArcanaGame({super.key, required this.levelData});

  @override
  State<CoherenceArcanaGame> createState() => _CoherenceArcanaGameState();
}

class _CoherenceArcanaGameState extends State<CoherenceArcanaGame> {
  // Game state variables.
  // These will be initialized from widget.levelData.
  late double _decoherenceMeterProgress;
  late List<CardData?> _utilitySlots;
  late List<List<CardData?>> _boardCells;
  late List<CardData?> _playerHand;

  @override
  void initState() {
    super.initState();
    _initializeGameState();
  }

  // Initializes all game state variables from the levelData.
  // This is also used by the 'Reset' button.
  void _initializeGameState() {
    _decoherenceMeterProgress = 0.0; // Always reset meter

    // Create deep copies of the lists from levelData.
    // This is crucial so that resizing the 'Reset' button works correctly
    // and doesn't just point to the already-modified state.
    _utilitySlots = List<CardData?>.from(widget.levelData.initialUtilitySlots);
    _boardCells = widget.levelData.initialBoardCells
        .map((row) => List<CardData?>.from(row))
        .toList();
    _playerHand = List<CardData?>.from(widget.levelData.initialPlayerHand);
  }

  // Handles a card being dropped onto the board.
  void _onCardDropped(int targetRow, int targetCol, Map<String, dynamic> data) {
    // Check if the decoherence meter is full using levelData.
    if (_decoherenceMeterProgress >= widget.levelData.maxDecoherence) {
      return; // Cannot take more actions.
    }

    // Ensure target cell is empty.
    if (_boardCells[targetRow][targetCol] != null) {
      return;
    }

    final CardData cardData = data['cardData'] as CardData;
    final String source = data['source'] as String;

    setState(() {
      // Place the card on the board.
      _boardCells[targetRow][targetCol] = cardData;

      // Remove the card from its original position.
      if (source == 'hand') {
        final int originalHandIndex = data['originalHandIndex'] as int;
        _playerHand[originalHandIndex] = null;
      } else if (source == 'board') {
        final int originalRow = data['originalRow'] as int;
        final int originalCol = data['originalCol'] as int;
        _boardCells[originalRow][originalCol] = null;
      }

      // Increase the decoherence meter using levelData.
      _decoherenceMeterProgress =
          (_decoherenceMeterProgress + widget.levelData.decoherencePerAction)
              .clamp(0.0, widget.levelData.maxDecoherence);
    });
  }

  // Handles a card being dropped back into the player's hand.
  void _onBoardCardDroppedToHand(
    int targetHandIndex,
    Map<String, dynamic> data,
  ) {
    if (_decoherenceMeterProgress >= widget.levelData.maxDecoherence) {
      return; // Cannot take more actions.
    }

    // Ensure target hand slot is empty.
    if (_playerHand[targetHandIndex] != null) {
      return;
    }

    final CardData cardData = data['cardData'] as CardData;
    final String source = data['source'] as String;

    if (source != 'board') {
      return;
    }

    final int originalBoardRow = data['originalRow'] as int;
    final int originalBoardCol = data['originalCol'] as int;

    setState(() {
      // Place the card in the hand.
      _playerHand[targetHandIndex] = cardData;
      // Remove the card from the board.
      _boardCells[originalBoardRow][originalBoardCol] = null;

      // Increase the decoherence meter.
      _decoherenceMeterProgress =
          (_decoherenceMeterProgress + widget.levelData.decoherencePerAction)
              .clamp(0.0, widget.levelData.maxDecoherence);
    });
  }

  // ignore: unused_element
  void _onCardDroppedToUtil() {
    // TODO: Implement logic
  }

  // Handles button presses (Discard, Measure, Reset).
  void _onButtonPressed(String action) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text('$action button pressed!')));
    if (action == 'Reset') {
      setState(() {
        _initializeGameState(); // Re-initialize all card positions from levelData.
      });
    } else if (action == 'Measure') {
      // TODO: Add logic for system submission and score calculation
    } else if (action == 'Discard') {
      // TODO: Add logic for discarding cards from player hand
    }
  }

  // Helper widget to build consistent section titles.
  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(
          title.toUpperCase(),
          style: GoogleFonts.getFont('Press Start 2P').copyWith(
            color: symbolColor, // Use theme color
            fontSize: 14,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor, // Use theme color
      body: SafeArea(
        child: SingleChildScrollView(
          physics: NeverScrollableScrollPhysics(),
          child: Column(
            children: <Widget>[
              // --- Level and Decoherence Meter Section ---
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: <Widget>[
                    Align(
                      alignment: Alignment.center,
                      child: Text(
                        // Use level number from levelData
                        'LEVEL ${widget.levelData.levelNumber}',
                        style: GoogleFonts.getFont('Press Start 2P').copyWith(
                          color: symbolColor, // Use theme color
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(height: 16.0),
                    Row(
                      children: <Widget>[
                        Text(
                          'DECOHERENCE METER',
                          style: GoogleFonts.getFont('Press Start 2P').copyWith(
                            color: symbolColor, // Use theme color
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(width: 8.0),
                        Expanded(
                          child: LinearProgressIndicator(
                            // Use levelData for meter calculation
                            value:
                                _decoherenceMeterProgress /
                                widget.levelData.maxDecoherence,
                            backgroundColor: meterTrackColor, // Use theme color
                            valueColor: const AlwaysStoppedAnimation<Color>(
                              meterFillColor, // Use theme color
                            ),
                            minHeight: 12.0,
                            borderRadius: BorderRadius.circular(6.0),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16.0),

              // --- Utility & Artifacts Section ---
              _buildSectionTitle('Utility & Artifacts'),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: LayoutBuilder(
                  builder: (BuildContext context, BoxConstraints constraints) {
                    final double cardWidth =
                        (constraints.maxWidth -
                            (16.0 * 2) -
                            (8.0 * (widget.levelData.utilitySlotCount - 1))) /
                        widget.levelData.utilitySlotCount;
                    final double cardHeight =
                        cardWidth * 1.4; // Aspect ratio for cards.

                    return GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        // Use levelData for count
                        crossAxisCount: widget.levelData.utilitySlotCount,
                        crossAxisSpacing: 8.0,
                        mainAxisSpacing: 8.0,
                        childAspectRatio: cardWidth / cardHeight,
                      ),
                      // Use levelData for count
                      itemCount: widget.levelData.utilitySlotCount,
                      itemBuilder: (BuildContext context, int index) {
                        return GameCard(
                          cardData:
                              _utilitySlots[index] ??
                              CardData.empty(
                                cardColor: emptySlotBackgroundColor,
                                symbolColor: symbolColor,
                              ),
                          cardBorderColor: cardBorderColor,
                          isEmpty: _utilitySlots[index] == null,
                          width: cardWidth,
                          height: cardHeight,
                        );
                      },
                    );
                  },
                ),
              ),
              const SizedBox(height: 24.0),

              // --- Board Section ---
              _buildSectionTitle('Board'),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: LayoutBuilder(
                  builder: (BuildContext context, BoxConstraints constraints) {
                    final double cardWidth =
                        (constraints.maxWidth -
                            (16.0 * 2) -
                            (8.0 * (widget.levelData.boardCols - 1))) /
                        widget.levelData.boardCols; // Use levelData
                    final double cardHeight = cardWidth * 1.4;

                    return GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount:
                            widget.levelData.boardCols, // Use levelData
                        crossAxisSpacing: 8.0,
                        mainAxisSpacing: 8.0,
                        childAspectRatio: cardWidth / cardHeight,
                      ),
                      itemCount:
                          widget.levelData.boardRows *
                          widget.levelData.boardCols, // Use levelData
                      itemBuilder: (BuildContext context, int index) {
                        final int row = index ~/ widget.levelData.boardCols;
                        final int col = index % widget.levelData.boardCols;
                        return BoardCardSlot(
                          row: row,
                          col: col,
                          cardData:
                              _boardCells[row][col] ??
                              CardData.empty(
                                cardColor: emptySlotBackgroundColor,
                                symbolColor: symbolColor,
                              ),
                          cardBorderColor: cardBorderColor,
                          onCardDropped: _onCardDropped,
                          isEmpty: _boardCells[row][col] == null,
                          width: cardWidth,
                          height: cardHeight,
                          canDrag:
                              _decoherenceMeterProgress <
                              widget.levelData.maxDecoherence, // Use levelData
                        );
                      },
                    );
                  },
                ),
              ),
              const SizedBox(height: 24.0),

              // --- Player Hand Section ---
              _buildSectionTitle('Player Hand'),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: LayoutBuilder(
                  builder: (BuildContext context, BoxConstraints constraints) {
                    final int cardsPerRow = math.min(
                      6,
                      widget.levelData.playerHandSize,
                    );
                    final double cardWidth =
                        (constraints.maxWidth -
                            (16.0 * 2) -
                            (8.0 * (cardsPerRow - 1))) /
                        cardsPerRow;
                    final double cardHeight = cardWidth * 1.4;

                    return Wrap(
                      spacing: 8.0,
                      runSpacing: 8.0,
                      alignment: WrapAlignment.start,
                      children: _playerHand.asMap().entries.map<Widget>((
                        entry,
                      ) {
                        final int index = entry.key;
                        final CardData? card = entry.value;
                        return HandCardSlot(
                          cardData:
                              card ??
                              CardData.empty(
                                cardColor: emptySlotBackgroundColor,
                                symbolColor: symbolColor,
                              ),
                          cardBorderColor: cardBorderColor,
                          originalHandIndex: index,
                          canDrag:
                              card != null &&
                              _decoherenceMeterProgress <
                                  widget.levelData.maxDecoherence,
                          width: cardWidth,
                          height: cardHeight,
                          onCardDroppedToHand: _onBoardCardDroppedToHand,
                        );
                      }).toList(),
                    );
                  },
                ),
              ),
              const SizedBox(height: 24.0),

              // --- Action Buttons Section ---
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16.0,
                  vertical: 8.0,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    Expanded(
                      child: GameButton(
                        text: 'DISCARD',
                        onPressed: () => _onButtonPressed('Discard'),
                      ),
                    ),
                    const SizedBox(width: 16.0),
                    Expanded(
                      child: GameButton(
                        text: 'MEASURE',
                        onPressed: () => _onButtonPressed('Measure'),
                      ),
                    ),
                    const SizedBox(width: 16.0),
                    Expanded(
                      child: GameButton(
                        text: 'RESET',
                        onPressed: () => _onButtonPressed('Reset'),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16.0),
            ],
          ),
        ),
      ),
    );
  }
}
