import 'package:coherence_arcana/widgets/card_data.dart';
import 'package:coherence_arcana/widgets/game_theme.dart';

final levelAnswers = [
  () {
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
  () {
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
  () {
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
  () {
    var board = List<List<CardData?>>.generate(
      3, // boardRows
      (int row) => List<CardData?>.filled(6, null), // boardCols
    );
    board[0][0] = CardData(
      id: 'Qubit psi',
      symbol: '|ψ⟩',
      cardColor: cardColor,
      symbolColor: symbolColor,
    );
    board[0][3] = CardData(
      id: 'Hadamard gate',
      symbol: 'H',
      cardColor: cardColor,
      symbolColor: symbolColor,
    );
    board[1][0] = CardData(
      id: 'Qubit 0',
      symbol: '|0⟩',
      cardColor: cardColor,
      symbolColor: symbolColor,
    );
    board[1][1] = CardData(
      id: 'Hadamard gate',
      symbol: 'H',
      cardColor: cardColor,
      symbolColor: symbolColor,
    );
    board[1][3] = CardData(
      id: 'CNOT gate',
      symbol: 'CNOT',
      cardColor: cardColor,
      symbolColor: symbolColor,
    );
    board[2][0] = CardData(
      id: 'Qubit 0',
      symbol: '|0⟩',
      cardColor: cardColor,
      symbolColor: symbolColor,
    );
    board[2][2] = CardData(
      id: 'CNOT gate',
      symbol: 'X',
      cardColor: cardColor,
      symbolColor: symbolColor,
    );
    board[2][3] = CardData(
      id: 'X gate',
      symbol: 'X',
      cardColor: cardColor,
      symbolColor: symbolColor,
    );
    board[2][4] = CardData(
      id: 'Z gate',
      symbol: 'Z',
      cardColor: cardColor,
      symbolColor: symbolColor,
    );
    return board;
  }(),
];

final levelMoves = [0, 10, 10, 10]; // Min number of moves to get full score
