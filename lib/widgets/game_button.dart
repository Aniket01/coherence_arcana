import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

const Color _buttonColor = Color(0xFFF9C07F); // Same as card border
const Color _buttonTextColor = Color(0xFF5C3D6D); // Dark purple
const Color _symbolColor = Color(0xFF5C3D6D); // Dark purple

// A reusable button widget for game actions.

class GameButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;

  const GameButton({super.key, required this.text, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        foregroundColor: _buttonTextColor,
        backgroundColor: _buttonColor,
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
          side: const BorderSide(color: _symbolColor, width: 2.0),
        ),
        textStyle: GoogleFonts.getFont(
          'Press Start 2P',
        ).copyWith(fontSize: 12, fontWeight: FontWeight.bold),
      ),
      child: Text(text),
    );
  }
}
