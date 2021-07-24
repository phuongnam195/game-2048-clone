import 'package:flutter/material.dart';

class GameButton extends StatelessWidget {
  final IconData icon;
  final bool highlight;
  final Function action;

  GameButton(
      {required this.icon, this.highlight = false, required this.action});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: AspectRatio(
        aspectRatio: 1 / 1,
        child: TextButton(
          child: FittedBox(
            child: Padding(
              padding: const EdgeInsets.all(4.0),
              child:
                  Icon(icon, color: highlight ? Colors.white : Colors.white70),
            ),
          ),
          style: TextButton.styleFrom(
            padding: EdgeInsets.zero,
            backgroundColor: highlight ? Colors.white54 : Colors.black26,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            elevation: 0,
          ),
          onPressed: () => action(),
        ),
      ),
    );
  }
}
