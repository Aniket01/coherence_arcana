import 'package:coherence_arcana/audio/audio_controller.dart';
import 'package:coherence_arcana/audio/sounds.dart';
import 'package:coherence_arcana/game_internals/answer.dart';
import 'package:coherence_arcana/game_internals/score.dart';
import 'package:coherence_arcana/views/post_game_view.dart';
import 'package:coherence_arcana/widgets/board_card_slot.dart';
import 'package:coherence_arcana/widgets/game_button.dart';
import 'package:coherence_arcana/widgets/game_card.dart';
import 'package:coherence_arcana/widgets/hand_card_slot.dart';
import 'package:coherence_arcana/level_selection/levels.dart';
import 'package:coherence_arcana/style/responsive_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../widgets/card_data.dart';
import 'dart:math' as math;
import '../widgets/game_theme.dart'; // Import the new theme file
import '../level_selection/level_data.dart'; // Import the new LevelData class

class CoherenceArcanaGame extends StatefulWidget {
  // The game now requires LevelData to be passed in.
  final LevelData? levelData;

  const CoherenceArcanaGame({super.key, this.levelData});

  @override
  State<CoherenceArcanaGame> createState() => _CoherenceArcanaGameState();
}

class _CoherenceArcanaGameState extends State<CoherenceArcanaGame> {
  // Game state variables.
  // These will be initialized from levelData.
  late final LevelData levelData;
  late double _decoherenceMeterProgress;
  late List<CardData?> _utilitySlots;
  late List<List<CardData?>> _boardCells;
  late List<CardData?> _playerHand;
  late int _artifactTaps;

  @override
  void initState() {
    super.initState();
    levelData = widget.levelData ?? gameLevels[0];
    _initializeGameState();
    _initAudio();
  }

  void _initAudio() async {
    final audioController = Provider.of<AudioController>(
      context,
      listen: false,
    );
    // Initialize returns quickly if already initialized
    await audioController.initialize();
    audioController.playMusic();
  }

  // Initializes all game state variables from the levelData.
  // This is also used by the 'Reset' button.
  void _initializeGameState() {
    _decoherenceMeterProgress = 0.0; // Always reset meter
    // Create deep copies of the lists from levelData.
    // This is crucial so that resizing the 'Reset' button works correctly
    // and doesn't just point to the already-modified state.
    _utilitySlots = List<CardData?>.from(levelData.initialUtilitySlots);
    _boardCells = levelData.initialBoardCells
        .map((row) => List<CardData?>.from(row))
        .toList();
    _playerHand = List<CardData?>.from(levelData.initialPlayerHand);
    _artifactTaps = 0;
  }

  // Handles a card being dropped onto the board.
  void _onCardDropped(int targetRow, int targetCol, Map<String, dynamic> data) {
    final audioController = Provider.of<AudioController>(
      context,
      listen: false,
    );
    // Check if the decoherence meter is full using levelData.
    if (_decoherenceMeterProgress >= levelData.maxDecoherence) {
      setState(() {
        audioController.playSfx(SfxType.cardNotPlaced);
      });
      return; // Cannot take more actions.
    }

    // Ensure target cell is empty.
    if (_boardCells[targetRow][targetCol] != null) {
      setState(() {
        audioController.playSfx(SfxType.cardNotPlaced);
      });
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

      final bool wasMeterFull =
          _decoherenceMeterProgress >= levelData.maxDecoherence;

      // Increase the decoherence meter using levelData.
      _decoherenceMeterProgress =
          (_decoherenceMeterProgress + levelData.decoherencePerAction).clamp(
            0.0,
            levelData.maxDecoherence,
          );

      audioController.playSfx(SfxType.cardPlaced);

      if (!wasMeterFull &&
          _decoherenceMeterProgress >= levelData.maxDecoherence) {
        audioController.playSfx(SfxType.meterFull);
      }
    });
  }

  // Handles a card being dropped back into the player's hand.
  void _onBoardCardDroppedToHand(
    int targetHandIndex,
    Map<String, dynamic> data,
  ) {
    final audioController = Provider.of<AudioController>(
      context,
      listen: false,
    );

    if (_decoherenceMeterProgress >= levelData.maxDecoherence) {
      setState(() {
        audioController.playSfx(SfxType.cardNotPlaced);
      });
      return; // Cannot take more actions.
    }

    // Ensure target hand slot is empty.
    if (_playerHand[targetHandIndex] != null) {
      setState(() {
        audioController.playSfx(SfxType.cardNotPlaced);
      });
      return;
    }

    final CardData cardData = data['cardData'] as CardData;
    final String source = data['source'] as String;

    if (source != 'board') {
      setState(() {
        audioController.playSfx(SfxType.cardNotPlaced);
      });
      return;
    }

    final int originalBoardRow = data['originalRow'] as int;
    final int originalBoardCol = data['originalCol'] as int;

    setState(() {
      // Place the card in the hand.
      _playerHand[targetHandIndex] = cardData;
      // Remove the card from the board.
      _boardCells[originalBoardRow][originalBoardCol] = null;

      final bool wasMeterFull =
          _decoherenceMeterProgress >= levelData.maxDecoherence;

      // Increase the decoherence meter.
      _decoherenceMeterProgress =
          (_decoherenceMeterProgress + levelData.decoherencePerAction).clamp(
            0.0,
            levelData.maxDecoherence,
          );

      audioController.playSfx(SfxType.cardPlaced);

      if (!wasMeterFull &&
          _decoherenceMeterProgress >= levelData.maxDecoherence) {
        audioController.playSfx(SfxType.meterFull);
      }
    });
  }

  // Handles button presses (Discard, Measure, Reset).
  void _onButtonPressed(String action) {
    final audioController = Provider.of<AudioController>(
      context,
      listen: false,
    );

    // Play a sound for any button press
    audioController.playSfx(SfxType.buttonClick);

    if (action == 'Reset') {
      setState(() {
        audioController.playSfx(SfxType.buttonClick);
        _initializeGameState();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Board reset!')),
        ); // Re-initialize all card positions from levelData.
      });
    } else if (action == 'Measure') {
      setState(() {
        audioController.playSfx(SfxType.buttonClick);
      });
      // Count non-null cards in player hand
      final int remainingCards = _playerHand
          .where((card) => card != null)
          .length;
      final gameScore = Score(level: levelData.levelNumber);
      gameScore.calculate(
        _boardCells,
        _decoherenceMeterProgress,
        _artifactTaps,
        remainingCards, // Pass count of non-null cards
      );
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => PostGameView(scoreData: gameScore),
        ),
      );
    } else if (action == 'Discard') {
      setState(() {
        audioController.playSfx(SfxType.buttonClick);
        // Find the last non-null card and remove it
        for (int i = _playerHand.length - 1; i >= 0; i--) {
          if (_playerHand[i] != null) {
            _playerHand[i] = null;
            break;
          }
        }
      });
    }
  }

  void _onTapArtifact(String cardId, int utilitySlotIndex) {
    final audioController = Provider.of<AudioController>(
      context,
      listen: false,
    );

    // Check if meter is full
    if (_decoherenceMeterProgress >= levelData.maxDecoherence) {
      audioController.playSfx(SfxType.cardNotPlaced);
      return;
    }

    // Get the correct answer board
    // levelNumber is 1-based, levelAnswers is 0-indexed
    if (levelData.levelNumber > levelAnswers.length) {
      // Safety check in case answer doesn't exist
      debugPrint("Error: No answer found for level ${levelData.levelNumber}");
      return;
    }
    final answerBoard = levelAnswers[levelData.levelNumber - 1];

    bool actionTaken = false;
    debugPrint("Tapped on card: $cardId");
    setState(() {
      if (cardId == 'Noise Filter') {
        // --- Noise Filter Logic ---
        // Get all card IDs from the answer board
        final answerCardIds = <String>{};
        for (final row in answerBoard) {
          for (final card in row) {
            if (card != null) {
              answerCardIds.add(card.id);
            }
          }
        }

        // Find the first card in hand that is NOT in the answer set
        for (int i = 0; i < _playerHand.length; i++) {
          final handCard = _playerHand[i];
          if (handCard != null && !answerCardIds.contains(handCard.id)) {
            _playerHand[i] = null; // Remove the card
            actionTaken = true;
            break; // Only remove one
          }
        }
      } else if (cardId == 'Stabilizer') {
        // --- Stabilizer Logic ---
        int? foundRow;
        int? foundCol;
        CardData? cardToMove;

        // Find the first wrongly placed card
        for (int r = 0; r < _boardCells.length; r++) {
          for (int c = 0; c < _boardCells[r].length; c++) {
            final placedCard = _boardCells[r][c];
            final correctCard =
                (r < answerBoard.length && c < answerBoard[r].length)
                ? answerBoard[r][c]
                : null;

            if (placedCard != null &&
                (correctCard == null || placedCard.id != correctCard.id)) {
              // This card is wrongly placed
              cardToMove = placedCard;
              foundRow = r;
              foundCol = c;
              break;
            }
          }
          if (cardToMove != null) break;
        }

        // If a wrong card was found, try to move it to hand
        if (cardToMove != null && foundRow != null && foundCol != null) {
          final int emptyHandSlot = _playerHand.indexOf(null);
          if (emptyHandSlot != -1) {
            _playerHand[emptyHandSlot] = cardToMove;
            _boardCells[foundRow][foundCol] = null; // Remove from board
            actionTaken = true;
          }
          // else: No space in hand, action fails (actionTaken remains false)
        }
      } else if (cardId == 'Coherent qubit') {
        // --- Coherent Qubit Logic ---
        _decoherenceMeterProgress -= (levelData.maxDecoherence * 0.20);
        _decoherenceMeterProgress = _decoherenceMeterProgress.clamp(
          0.0,
          levelData.maxDecoherence,
        );
        actionTaken = true;
      }

      // If action was successful, consume the artifact and update meter/taps
      if (actionTaken) {
        _utilitySlots[utilitySlotIndex] = null; // Consume the artifact card
        _artifactTaps++; // Increment tap counter
        audioController.playSfx(
          SfxType.utilPlaced,
        ); // Or a new "artifactUsed" sound
        // This action does NOT increase the decoherence meter.
      } else {
        audioController.playSfx(SfxType.cardNotPlaced);
      }
    });
  }

  // Helper widget to build consistent section titles.
  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(top: 2.0, left: 8.0, right: 8.0),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(
          title.toUpperCase(),
          style: GoogleFonts.getFont('Press Start 2P').copyWith(
            color: symbolColor, // Use theme color
            fontSize: 14,
            fontWeight: FontWeight.bold,
            height: 0,
          ),
        ),
      ),
    );
  }

  // Builds the widget for the top message area (Level + Decoherence Meter).
  Widget _buildTopMessageArea() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Align(
          alignment: Alignment.center,
          child: Text(
            // Use level number from levelData
            'LEVEL ${levelData.levelNumber}',
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
                value: _decoherenceMeterProgress / levelData.maxDecoherence,
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
    );
  }

  // Builds the widget for the squarish main area (Utility + Board).
  Widget _buildSquarishMainArea() {
    // This area scrolls if the content is too tall.
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // --- Board Section ---
          _buildSectionTitle('Board'),
          LayoutBuilder(
            builder: (BuildContext context, BoxConstraints constraints) {
              final double cardWidth =
                  (constraints.maxWidth -
                      (16.0 * 2) -
                      (8.0 * (levelData.boardCols - 1))) /
                  levelData.boardCols; // Use levelData
              final double cardHeight = cardWidth * 1.4;

              return GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: levelData.boardCols, // Use levelData
                  crossAxisSpacing: 8.0,
                  mainAxisSpacing: 8.0,
                  childAspectRatio: cardWidth / cardHeight,
                ),
                itemCount:
                    levelData.boardRows * levelData.boardCols, // Use levelData
                itemBuilder: (BuildContext context, int index) {
                  final int row = index ~/ levelData.boardCols;
                  final int col = index % levelData.boardCols;
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
                        levelData.maxDecoherence, // Use levelData
                  );
                },
              );
            },
          ),
        ],
      ),
    );
  }

  // Builds the widget for the rectangular menu area (Player Hand + Buttons).
  Widget _buildRectangularMenuArea() {
    // This area scrolls if the content is too tall.
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // --- Utility & Artifacts Section ---
          _buildSectionTitle('Utility & Artifacts'),
          LayoutBuilder(
            builder: (BuildContext context, BoxConstraints constraints) {
              final double cardWidth =
                  (constraints.maxWidth -
                      (16.0 * 2) -
                      (8.0 * (levelData.utilitySlotCount - 1))) /
                  levelData.utilitySlotCount;
              final double cardHeight =
                  cardWidth * 1.4; // Aspect ratio for cards.

              return GridView.builder(
                padding: EdgeInsets.zero,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  // Use levelData for count
                  crossAxisCount: levelData.utilitySlotCount,
                  crossAxisSpacing: 8.0,
                  mainAxisSpacing: 8.0,
                  childAspectRatio: cardWidth / cardHeight,
                ),
                // Use levelData for count
                itemCount: levelData.utilitySlotCount,
                itemBuilder: (BuildContext context, int index) {
                  final CardData? card = _utilitySlots[index];
                  // Check if the card is a known artifact by its ID
                  final bool isArtifact =
                      card != null &&
                      (card.id == 'Noise Filter' ||
                          card.id == 'Stabilizer' ||
                          card.id == 'Coherent qubit');

                  return GestureDetector(
                    onTap: isArtifact
                        ? () => _onTapArtifact(card.id, index)
                        : null, // Only tappable if it's a known artifact
                    child: GameCard(
                      cardData:
                          card ??
                          CardData.empty(
                            cardColor: emptySlotBackgroundColor,
                            symbolColor: symbolColor,
                          ),
                      cardBorderColor: cardBorderColor,
                      isEmpty: card == null,
                      width: cardWidth,
                      height: cardHeight,
                    ),
                  );
                },
              );
            },
          ),
          const SizedBox(height: 12.0),

          // --- Player Hand Section ---
          _buildSectionTitle('Player Hand'),
          LayoutBuilder(
            builder: (BuildContext context, BoxConstraints constraints) {
              final int cardsPerRow = math.min(6, levelData.playerHandSize);
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
                children: _playerHand.asMap().entries.map<Widget>((entry) {
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
                        _decoherenceMeterProgress < levelData.maxDecoherence,
                    width: cardWidth,
                    height: cardHeight,
                    onCardDroppedToHand: _onBoardCardDroppedToHand,
                  );
                }).toList(),
              );
            },
          ),
          const SizedBox(height: 24.0),

          // --- Action Buttons Section ---
          Row(
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
          const SizedBox(height: 16.0),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      // Use the ResponsiveScreen as the new body
      body: ResponsiveScreen(
        topMessageArea: _buildTopMessageArea(),
        squarishMainArea: _buildSquarishMainArea(),
        rectangularMenuArea: _buildRectangularMenuArea(),
      ),
    );
  }
}
