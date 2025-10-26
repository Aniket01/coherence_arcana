import 'package:coherence_arcana/widgets/card_data.dart';
import 'package:coherence_arcana/widgets/game_theme.dart';

final levelAnswers = [
  () {
    var board = List<List<CardData?>>.generate(
      2, // boardRows
      (int row) => List<CardData?>.filled(3, null), //boardCols
    );
    board[0][0] = CardData(
      id: 'Qubit 0',
      symbol: '|0⟩',
      cardColor: cardColor,
      symbolColor: symbolColor,
    );
    board[0][1] = CardData(
      id: 'Hadamard gate',
      symbol: 'H',
      cardColor: cardColor,
      symbolColor: symbolColor,
    );
    board[0][2] = CardData(
      id: 'control down',
      symbol: 'CNOT',
      cardColor: cardColor,
      symbolColor: symbolColor,
    );
    board[1][0] = CardData(
      id: 'Qubit 0',
      symbol: '|0⟩',
      cardColor: cardColor,
      symbolColor: symbolColor,
    );
    board[1][2] = CardData(
      id: 'target up',
      symbol: 'CNOT',
      cardColor: cardColor,
      symbolColor: symbolColor,
    );
    return board;
  }(),
  () {
    var board = List<List<CardData?>>.generate(
      2, // boardRows
      (int row) => List<CardData?>.filled(4, null), //boardCols
    );
    board[0][0] = CardData(
      id: 'Qubit phi',
      symbol: '|ψ⟩',
      cardColor: cardColor,
      symbolColor: symbolColor,
    );
    board[0][1] = CardData(
      id: 'control down',
      symbol: 'CNOT',
      cardColor: cardColor,
      symbolColor: symbolColor,
    );
    board[0][2] = CardData(
      id: 'target down',
      symbol: 'CNOT',
      cardColor: cardColor,
      symbolColor: symbolColor,
    );
    board[0][3] = CardData(
      id: 'control down',
      symbol: 'CNOT',
      cardColor: cardColor,
      symbolColor: symbolColor,
    );
    board[1][0] = CardData(
      id: 'Qubit psi',
      symbol: '|ψ⟩',
      cardColor: cardColor,
      symbolColor: symbolColor,
    );
    board[1][1] = CardData(
      id: 'target up',
      symbol: 'CNOT',
      cardColor: cardColor,
      symbolColor: symbolColor,
    );
    board[1][2] = CardData(
      id: 'control up',
      symbol: 'CNOT',
      cardColor: cardColor,
      symbolColor: symbolColor,
    );
    board[1][3] = CardData(
      id: 'target up',
      symbol: 'CNOT',
      cardColor: cardColor,
      symbolColor: symbolColor,
    );
    return board;
  }(),
  () {
    var board = List<List<CardData?>>.generate(
      3, // boardRows
      (int row) => List<CardData?>.filled(4, null), //boardCols
    );
    board[0][0] = CardData(
      id: 'Qubit 0',
      symbol: '|ψ⟩',
      cardColor: cardColor,
      symbolColor: symbolColor,
    );
    board[0][1] = CardData(
      id: 'Hadamard gate',
      symbol: 'H',
      cardColor: cardColor,
      symbolColor: symbolColor,
    );
    board[0][2] = CardData(
      id: 'control down',
      symbol: 'CNOT',
      cardColor: cardColor,
      symbolColor: symbolColor,
    );
    board[1][0] = CardData(
      id: 'Qubit 0',
      symbol: '|ψ⟩',
      cardColor: cardColor,
      symbolColor: symbolColor,
    );
    board[1][2] = CardData(
      id: 'target up',
      symbol: 'CNOT',
      cardColor: cardColor,
      symbolColor: symbolColor,
    );
    board[1][3] = CardData(
      id: 'control down',
      symbol: '|ψ⟩',
      cardColor: cardColor,
      symbolColor: symbolColor,
    );
    board[2][0] = CardData(
      id: 'Qubit 0',
      symbol: '|ψ⟩',
      cardColor: cardColor,
      symbolColor: symbolColor,
    );
    board[2][3] = CardData(
      id: 'target up',
      symbol: 'CNOT',
      cardColor: cardColor,
      symbolColor: symbolColor,
    );
    return board;
  }(),
  () {
    var board = List<List<CardData?>>.generate(
      2, // boardRows
      (int row) => List<CardData?>.filled(7, null), // boardCols
    );
    board[0][0] = CardData(
      id: 'Qubit',
      symbol: '|Q⟩',
      cardColor: cardColor,
      symbolColor: symbolColor,
    );
    board[0][1] = CardData(
      id: 'Hadamard gate',
      symbol: 'H',
      cardColor: cardColor,
      symbolColor: symbolColor,
    );
    board[0][2] = CardData(
      id: 'control down',
      symbol: 'CNOT',
      cardColor: cardColor,
      symbolColor: symbolColor,
    );
    board[0][3] = CardData(
      id: 'Z gate',
      symbol: 'Z',
      cardColor: cardColor,
      symbolColor: symbolColor,
    );
    board[0][4] = CardData(
      id: 'X gate',
      symbol: 'X',
      cardColor: cardColor,
      symbolColor: symbolColor,
    );
    board[0][5] = CardData(
      id: 'control down',
      symbol: 'CNOT',
      cardColor: cardColor,
      symbolColor: symbolColor,
    );
    board[0][6] = CardData(
      id: 'Hadamard gate',
      symbol: 'H',
      cardColor: cardColor,
      symbolColor: symbolColor,
    );
    board[1][0] = CardData(
      id: 'Qubit',
      symbol: '|Q⟩',
      cardColor: cardColor,
      symbolColor: symbolColor,
    );
    board[1][2] = CardData(
      id: 'target up',
      symbol: 'CNOT',
      cardColor: cardColor,
      symbolColor: symbolColor,
    );
    board[1][5] = CardData(
      id: 'target up',
      symbol: 'CNOT',
      cardColor: cardColor,
      symbolColor: symbolColor,
    );
    return board;
  }(),
];

final levelMoves = [5, 8, 8, 10]; // Min number of moves to get full score
