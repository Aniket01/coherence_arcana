// A widget that represents a slot in the player's hand.
// It can be a Draggable card or an empty DragTarget.
import 'package:coherence_arcana/card_data.dart';
import 'package:coherence_arcana/game_card.dart';
import 'package:flutter/material.dart';

const Color _symbolColor = Color(0xFF5C3D6D);
const Color _emptySlotBackgroundColor = Color(0x33F9C07F);

class HandCardSlot extends StatefulWidget {
  final CardData cardData;
  final Color cardBorderColor;
  final int originalHandIndex; // To know which card slot in hand to clear.
  final bool canDrag; // Whether this card can be dragged.
  final double width;
  final double height;
  final Function(int targetHandIndex, Map<String, dynamic> data)
  onCardDroppedToHand;

  const HandCardSlot({
    super.key,
    required this.cardData,
    required this.cardBorderColor,
    required this.originalHandIndex,
    required this.canDrag,
    required this.width,
    required this.height,
    required this.onCardDroppedToHand,
  });

  @override
  State<HandCardSlot> createState() => _HandCardSlotState();
}

class _HandCardSlotState extends State<HandCardSlot> {
  bool _isHighlighted = false;

  @override
  Widget build(BuildContext context) {
    Widget cardContent = GameCard(
      cardData: widget.cardData,
      cardBorderColor: widget.cardBorderColor,
      isEmpty: widget.cardData.symbol.isEmpty,
      width: widget.width,
      height: widget.height,
    );

    if (widget.cardData.symbol.isNotEmpty && widget.canDrag) {
      // If it's a real card AND can drag, make it draggable.
      cardContent = Draggable<Map<String, dynamic>>(
        data: <String, dynamic>{
          'source': 'hand',
          'cardData': widget.cardData,
          'originalHandIndex': widget.originalHandIndex,
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
          isEmpty: true,
          width: widget.width,
          height: widget.height,
        ),
        affinity: Axis.horizontal,
        child: cardContent,
      );
    }

    // Empty slots in the hand should also be DragTargets to receive cards from the board.
    if (widget.cardData.symbol.isEmpty) {
      return DragTarget<Map<String, dynamic>>(
        onWillAcceptWithDetails: (DragTargetDetails<Map<String, dynamic>> details) {
          // Only accept if this slot is empty AND the incoming card is from the board.
          final bool canAccept =
              widget.cardData.symbol.isEmpty &&
              (details.data['source'] as String) == 'board';
          setState(() {
            _isHighlighted = canAccept;
          });
          return canAccept;
        },
        onAcceptWithDetails: (DragTargetDetails<Map<String, dynamic>> details) {
          setState(() {
            _isHighlighted = false;
          });
          widget.onCardDroppedToHand(widget.originalHandIndex, details.data);
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
                child: cardContent, // This is the empty GameCard
              );
            },
      );
    } else {
      // If it's not an empty slot, just return the draggable card content.
      return cardContent;
    }
  }
}
