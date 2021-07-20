import 'package:flutter/material.dart';

class GameButton extends StatelessWidget {
  final IconData icon;
  final Function action;

  GameButton(this.icon, this.action);

  @override
  Widget build(BuildContext context) {
    const double SIDE = 42;

    return ConstrainedBox(
      constraints: BoxConstraints(
          maxHeight: SIDE, maxWidth: SIDE, minHeight: SIDE, minWidth: SIDE),
      child: TextButton(
        child: Icon(icon, color: Colors.white70),
        style: TextButton.styleFrom(
          padding: EdgeInsets.zero,
          backgroundColor: Colors.black.withOpacity(0.3),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          elevation: 0,
        ),
        onPressed: () => action(),
      ),
    );
  }
}
