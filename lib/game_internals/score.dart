import 'package:coherence_arcana/game_internals/answer.dart';
import 'package:coherence_arcana/widgets/card_data.dart';

class Score {
  double score;
  int stars;
  final int level;
  Score({this.score = 0, this.stars = 0, this.level = 1});

  void calculate(
    List<List<CardData?>> boardCells,
    double moves,
    int? artifactTaps,
  ) {
    // Normalize boardCells to a matrix of nullable ids (String?)
    List<List<String?>> toIdMatrix(List<List<CardData?>> matrix) {
      return matrix.map((row) => row.map((c) => c?.id).toList()).toList();
    }

    final actualIds = toIdMatrix(boardCells);

    // Build expected ids from levelAnswers[level - 1].
    final dynamic expectedRaw = levelAnswers[level - 1];
    List<List<String?>> expectedIds = [];

    if (expectedRaw is List) {
      expectedIds = expectedRaw.map<List<String?>>((row) {
        if (row is List) {
          return row.map<String?>((cell) {
            if (cell is CardData) return cell.id;
            if (cell is String) return cell;
            return null;
          }).toList();
        }
        return <String?>[];
      }).toList();
    }

    // Deep compare matrices of ids.
    bool boardsMatch = false;
    if (actualIds.length == expectedIds.length) {
      boardsMatch = true;
      for (var r = 0; r < actualIds.length; r++) {
        final aRow = actualIds[r];
        final eRow = expectedIds[r];
        if (aRow.length != eRow.length) {
          boardsMatch = false;
          break;
        }
        for (var c = 0; c < aRow.length; c++) {
          if (aRow[c] != eRow[c]) {
            boardsMatch = false;
            break;
          }
        }
        if (!boardsMatch) break;
      }
    }

    if (boardsMatch) {
      double s = 100.0;

      // Only apply move-based deduction if moves looks like a valid move count.
      // Treat moves < 1 as "unknown" and skip move deduction (prevents passing decoherence).
      if (moves >= 1.0) {
        s -= ((moves / 2.0) - levelMoves[level - 1]) * 5.0;
      }

      s -= (artifactTaps ?? 0) * 10.0;

      // Clamp score between 0 and 100.
      score = s.clamp(0.0, 100.0).toDouble();
    } else {
      score = 0.0;
    }

    // Use clearer thresholds for stars.
    if (score >= 85.0) {
      stars = 3;
    } else if (score >= 65.0) {
      stars = 2;
    } else if (score >= 20.0) {
      stars = 1;
    } else {
      stars = 0;
    }
  }
}
