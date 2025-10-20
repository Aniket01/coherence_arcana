// A widget that acts as a target for dropped cards on the board, and makes existing cards draggable.
import 'package:coherence_arcana/card_data.dart';
import 'package:coherence_arcana/game_card.dart';
import 'package:flutter/material.dart';

const Color _symbolColor = Color(0xFF5C3D6D); // Dark purple
const Color _emptySlotBackgroundColor = Color(
  0x33F9C07F,
); // Transparent version of card border for empty slots

class BoardCardSlot extends StatefulWidget {
  final int row;
  final int col;
  final CardData cardData;
  final Color cardBorderColor;
  final Function(int row, int col, Map<String, dynamic> data) onCardDropped;
  final bool isEmpty;
  final double width;
  final double height;
  final bool canDrag; // Whether this card on the board can be dragged.

  const BoardCardSlot({
    super.key,
    required this.row,
    required this.col,
    required this.cardData,
    required this.cardBorderColor,
    required this.onCardDropped,
    required this.isEmpty,
    required this.width,
    required this.height,
    required this.canDrag,
  });

  @override
  State<BoardCardSlot> createState() => _BoardCardSlotState();
}

class _BoardCardSlotState extends State<BoardCardSlot> {
  bool _isHighlighted = false;

  @override
  Widget build(BuildContext context) {
    Widget cardWidget = GameCard(
      cardData: widget.cardData,
      cardBorderColor: widget.cardBorderColor,
      isEmpty: widget.isEmpty,
      width: widget.width,
      height: widget.height,
    );

    if (!widget.isEmpty && widget.canDrag) {
      // If there's a card in the slot and it can be dragged, make it draggable.
      cardWidget = Draggable<Map<String, dynamic>>(
        data: <String, dynamic>{
          'source': 'board',
          'cardData': widget.cardData,
          'originalRow': widget.row,
          'originalCol': widget.col,
        },
        feedback: Opacity(
          opacity: 0.7,
          child: GameCard(
            cardData: widget.cardData,
            cardBorderColor: widget.cardBorderColor,
            width: widget.width,
            height: widget.height,
          ),
        ),
        childWhenDragging: GameCard(
          cardData: CardData.empty(
            cardColor: _emptySlotBackgroundColor,
            symbolColor: _symbolColor,
          ),
          cardBorderColor: widget.cardBorderColor,
          isEmpty: true, // Show empty slot visually when card is dragged.
          width: widget.width,
          height: widget.height,
        ),
        child: cardWidget, // The actual card in its original position.
        affinity: Axis.horizontal,
      );
    }

    return DragTarget<Map<String, dynamic>>(
      onWillAcceptWithDetails: (DragTargetDetails<Map<String, dynamic>> details) {
        // Only accept if the slot is empty AND the incoming card is from the hand.
        // Board slots only accept new cards from the hand.
        final bool canAccept =
            widget.isEmpty && (details.data['source'] as String) == 'hand';
        setState(() {
          _isHighlighted = canAccept;
        });
        return canAccept;
      },
      onAcceptWithDetails: (DragTargetDetails<Map<String, dynamic>> details) {
        setState(() {
          _isHighlighted = false;
        });
        widget.onCardDropped(widget.row, widget.col, details.data);
      },
      onLeave: (Map<String, dynamic>? data) {
        setState(() {
          _isHighlighted = false;
        });
      },
      builder:
          (
            BuildContext context,
            List<Map<String, dynamic>?> candidateData,
            List<dynamic> rejectedData,
          ) {
            return Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8.0),
                border: Border.all(
                  color: _isHighlighted
                      ? Colors.greenAccent
                      : widget.cardBorderColor,
                  width: _isHighlighted ? 3.0 : 2.0,
                ),
              ),
              child:
                  cardWidget, // This now renders either the draggable card or the simple game card.
            );
          },
    );
  }
}
