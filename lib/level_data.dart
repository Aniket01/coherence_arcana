import 'card_data.dart';

// A data class to hold all the configuration for a single level.
class LevelData {
  final int levelNumber;

  // Game dimensions and limits.
  final int boardRows;
  final int boardCols;
  final int playerHandSize;
  final int utilitySlotCount;
  final double maxDecoherence;
  final double decoherencePerAction;

  // Initial game state.
  final List<CardData?> initialUtilitySlots;
  final List<List<CardData?>> initialBoardCells;
  final List<CardData?> initialPlayerHand;

  const LevelData({
    required this.levelNumber,
    required this.boardRows,
    required this.boardCols,
    required this.playerHandSize,
    required this.utilitySlotCount,
    required this.maxDecoherence,
    required this.decoherencePerAction,
    required this.initialUtilitySlots,
    required this.initialBoardCells,
    required this.initialPlayerHand,
  });
}
