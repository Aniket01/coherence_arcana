import 'package:coherence_arcana/board_card_slot.dart';
import 'package:coherence_arcana/game_button.dart';
import 'package:coherence_arcana/game_card.dart';
import 'package:coherence_arcana/hand_card_slot.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'card_data.dart';

// Constants for theme colors, making it easy to change the color scheme.
const Color _backgroundColor = Color(0xFFFDD8AA); // Light orange/peach
const Color _cardColor = Color(0xFFE89393); // Pinkish salmon
const Color _cardBorderColor = Color(
  0xFFF9C07F,
); // Slightly darker peach for contrast
const Color _symbolColor = Color(0xFF5C3D6D); // Dark purple
const Color _meterFillColor = Color(0xFF5C3D6D); // Dark purple
const Color _meterTrackColor = Color(0xFFC7B198); // Lighter track color
const Color _emptySlotBackgroundColor = Color(
  0x33F9C07F,
); // Transparent version of card border for empty slots

class CoherenceArcanaGame extends StatefulWidget {
  const CoherenceArcanaGame({super.key});

  @override
  State<CoherenceArcanaGame> createState() => _CoherenceArcanaGameState();
}

class _CoherenceArcanaGameState extends State<CoherenceArcanaGame> {
  // Game dimensions and limits.
  static const int _boardRows = 3;
  static const int _boardCols = 5;
  static const int _playerHandSize = 5;
  static const int _utilitySlotCount = 4;
  static const double _maxDecoherence =
      30.0; // Maximum value for the decoherence meter.
  static const double _decoherencePerAction =
      2.0; // Amount meter increases per card drop.

  // Game state variables.
  double _decoherenceMeterProgress =
      0.0; // Current progress of the decoherence meter.
  late List<CardData?>
  _utilitySlots; // List of utility cards. Null for empty slots.
  late List<List<CardData?>>
  _boardCells; // 2D list representing the game board. Null for empty cells.
  late List<CardData?>
  _playerHand; // List of cards in the player's hand. Null for empty hand slots.

  @override
  void initState() {
    super.initState();
    _initializeGameState();
  }

  // Initializes all game state variables with starting data.
  void _initializeGameState() {
    // Utility & Artifacts cards initialization.
    _utilitySlots = <CardData?>[
      CardData(
        id: 'filter-card',
        symbol: 'FILTER',
        cornerIconTopLeft: Icons.tune,
        cornerIconBottomRight: Icons.timer,
        cardColor: _cardColor,
        symbolColor: _symbolColor,
      ),
      CardData(
        id: 'potion-card',
        symbol: 'POTION',
        cornerIconTopLeft: Icons.lightbulb_outline,
        cornerIconBottomRight: Icons.bolt, // Representing the 'spark' icon.
        cardColor: _cardColor,
        symbolColor: _symbolColor,
      ),
      null, // Empty slot
      null, // Empty slot
    ];

    // Board cells initialization.
    _boardCells = List<List<CardData?>>.generate(
      _boardRows,
      (int row) => List<CardData?>.filled(_boardCols, null),
    );
    // Populate some initial board cells based on the image.
    _boardCells[0][0] = CardData(
      id: 'psi-card-00',
      symbol: '|ψ⟩',
      cornerIconTopLeft: Icons.schedule,
      cornerIconBottomRight: Icons.schedule,
      cardColor: _cardColor,
      symbolColor: _symbolColor,
    );
    _boardCells[0][3] = CardData(
      id: 'h-card-03',
      symbol: 'H',
      cornerIconTopLeft: Icons.settings_input_component,
      cornerIconBottomRight: Icons.settings_input_component,
      cardColor: _cardColor,
      symbolColor: _symbolColor,
    );
    _boardCells[1][0] = CardData(
      id: 'zero-card-10',
      symbol: '|0⟩',
      cornerIconTopLeft: Icons.schedule,
      cornerIconBottomRight: Icons.schedule,
      cardColor: _cardColor,
      symbolColor: _symbolColor,
    );
    _boardCells[1][1] = CardData(
      id: 'h-card-11',
      symbol: 'H',
      cornerIconTopLeft: Icons.settings_input_component,
      cornerIconBottomRight: Icons.settings_input_component,
      cardColor: _cardColor,
      symbolColor: _symbolColor,
    );
    _boardCells[1][3] = CardData(
      id: 'cnot-card-13',
      symbol: 'CNOT', // Simplified symbol for CNOT gate
      cornerIconTopLeft: Icons.settings_input_component,
      cornerIconBottomRight: Icons.settings_input_component,
      cardColor: _cardColor,
      symbolColor: _symbolColor,
    );
    _boardCells[2][0] = CardData(
      id: 'zero-card-20',
      symbol: '|0⟩',
      cornerIconTopLeft: Icons.schedule,
      cornerIconBottomRight: Icons.schedule,
      cardColor: _cardColor,
      symbolColor: _symbolColor,
    );
    _boardCells[2][3] = CardData(
      id: 'x-card-23',
      symbol: 'X',
      cornerIconTopLeft: Icons.settings_input_component,
      cornerIconBottomRight: Icons.settings_input_component,
      cardColor: _cardColor,
      symbolColor: _symbolColor,
    );
    _boardCells[2][4] = CardData(
      id: 'z-card-24',
      symbol: 'Z',
      cornerIconTopLeft: Icons.settings_input_component,
      cornerIconBottomRight: Icons.settings_input_component,
      cardColor: _cardColor,
      symbolColor: _symbolColor,
    );

    // Player hand initialization.
    _playerHand = <CardData?>[
      CardData(
        id: 'one-hand',
        symbol: '|1⟩',
        cornerIconTopLeft: Icons.schedule,
        cornerIconBottomRight: Icons.schedule,
        cardColor: _cardColor,
        symbolColor: _symbolColor,
      ),
      CardData(
        id: 'zero-hand',
        symbol: '|0⟩',
        cornerIconTopLeft: Icons.schedule,
        cornerIconBottomRight: Icons.schedule,
        cardColor: _cardColor,
        symbolColor: _symbolColor,
      ),
      CardData(
        id: 'p-hand',
        symbol: 'P',
        cornerIconTopLeft: Icons.settings_input_component,
        cornerIconBottomRight: Icons.settings_input_component,
        cardColor: _cardColor,
        symbolColor: _symbolColor,
      ),
      CardData(
        id: 'cnot-hand',
        symbol: 'CNOT', // Simplified symbol
        cornerIconTopLeft: Icons.settings_input_component,
        cornerIconBottomRight: Icons.settings_input_component,
        cardColor: _cardColor,
        symbolColor: _symbolColor,
      ),
      CardData(
        id: 'decohered-hand',
        symbol: 'DECOHERED',
        cornerIconTopLeft: Icons.blur_on, // Placeholder for decohered visual.
        cornerIconBottomRight:
            Icons.scatter_plot, // Placeholder for decohered visual.
        cardColor: _cardColor,
        symbolColor: _symbolColor,
      ),
    ];
  }

  // Handles a card being dropped onto the board.
  void _onCardDropped(int targetRow, int targetCol, Map<String, dynamic> data) {
    // Check if the decoherence meter is full.
    if (_decoherenceMeterProgress >= _maxDecoherence) {
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

      // Increase the decoherence meter.
      _decoherenceMeterProgress =
          (_decoherenceMeterProgress + _decoherencePerAction).clamp(
            0.0,
            _maxDecoherence,
          );
    });
  }

  // Handles a card being dropped back into the player's hand.
  void _onBoardCardDroppedToHand(
    int targetHandIndex,
    Map<String, dynamic> data,
  ) {
    if (_decoherenceMeterProgress >= _maxDecoherence) {
      return; // Cannot take more actions.
    }

    // Ensure target hand slot is empty.
    if (_playerHand[targetHandIndex] != null) {
      return;
    }

    final CardData cardData = data['cardData'] as CardData;
    final String source = data['source'] as String;

    // This callback is specifically for dropping *board* cards *to hand*.
    // So 'source' should always be 'board'.
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
          (_decoherenceMeterProgress + _decoherencePerAction).clamp(
            0.0,
            _maxDecoherence,
          );
    });
  }

  // Handles button presses (Discard, Measure, Reset).
  void _onButtonPressed(String action) {
    // Placeholder for actual game logic.
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text('$action button pressed!')));
    if (action == 'Reset') {
      setState(() {
        _decoherenceMeterProgress = 0.0; // Reset meter.
        _initializeGameState(); // Re-initialize all card positions.
      });
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
            color: _symbolColor,
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
      backgroundColor: _backgroundColor,
      body: SafeArea(
        child: SingleChildScrollView(
          // Wrapped the Column in SingleChildScrollView to prevent overflow
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
                        'LEVEL 4',
                        style: GoogleFonts.getFont('Press Start 2P').copyWith(
                          color: _symbolColor,
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
                            color: _symbolColor,
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(width: 8.0),
                        Expanded(
                          child: LinearProgressIndicator(
                            value: _decoherenceMeterProgress / _maxDecoherence,
                            backgroundColor: _meterTrackColor,
                            valueColor: const AlwaysStoppedAnimation<Color>(
                              _meterFillColor,
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
                        (constraints.maxWidth - (16.0 * 2) - (8.0 * 3)) / 4;
                    final double cardHeight =
                        cardWidth * 1.4; // Aspect ratio for cards.

                    return GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: _utilitySlotCount,
                        crossAxisSpacing: 8.0,
                        mainAxisSpacing: 8.0,
                        childAspectRatio: cardWidth / cardHeight,
                      ),
                      itemCount: _utilitySlotCount,
                      itemBuilder: (BuildContext context, int index) {
                        return GameCard(
                          cardData:
                              _utilitySlots[index] ??
                              CardData.empty(
                                cardColor: _emptySlotBackgroundColor,
                                symbolColor: _symbolColor,
                              ),
                          cardBorderColor: _cardBorderColor,
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
                // Removed Expanded as parent is SingleChildScrollView
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: LayoutBuilder(
                  builder: (BuildContext context, BoxConstraints constraints) {
                    final double cardWidth =
                        (constraints.maxWidth -
                            (16.0 * 2) -
                            (8.0 * (_boardCols - 1))) /
                        _boardCols;
                    final double cardHeight =
                        cardWidth * 1.4; // Aspect ratio for cards.

                    return GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: _boardCols,
                        crossAxisSpacing: 8.0,
                        mainAxisSpacing: 8.0,
                        childAspectRatio: cardWidth / cardHeight,
                      ),
                      itemCount: _boardRows * _boardCols,
                      itemBuilder: (BuildContext context, int index) {
                        final int row = index ~/ _boardCols;
                        final int col = index % _boardCols;
                        return BoardCardSlot(
                          row: row,
                          col: col,
                          cardData:
                              _boardCells[row][col] ??
                              CardData.empty(
                                cardColor: _emptySlotBackgroundColor,
                                symbolColor: _symbolColor,
                              ),
                          cardBorderColor: _cardBorderColor,
                          onCardDropped: _onCardDropped,
                          isEmpty: _boardCells[row][col] == null,
                          width: cardWidth,
                          height: cardHeight,
                          canDrag: _decoherenceMeterProgress < _maxDecoherence,
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
                    final double cardWidth =
                        (constraints.maxWidth -
                            (16.0 * 2) -
                            (8.0 * (_playerHandSize - 1))) /
                        _playerHandSize;
                    final double cardHeight =
                        cardWidth * 1.4; // Aspect ratio for cards.

                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: _playerHand.asMap().entries.map<Widget>((
                        MapEntry<int, CardData?> entry,
                      ) {
                        final int index = entry.key;
                        final CardData? card = entry.value;
                        return HandCardSlot(
                          // Changed from DraggableCard
                          cardData:
                              card ??
                              CardData.empty(
                                cardColor: _emptySlotBackgroundColor,
                                symbolColor: _symbolColor,
                              ),
                          cardBorderColor: _cardBorderColor,
                          originalHandIndex: index,
                          canDrag:
                              card != null &&
                              _decoherenceMeterProgress < _maxDecoherence,
                          width: cardWidth,
                          height: cardHeight,
                          onCardDroppedToHand:
                              _onBoardCardDroppedToHand, // New callback
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
