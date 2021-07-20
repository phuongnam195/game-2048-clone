import 'package:flutter/material.dart';

class MainButton extends StatelessWidget {
  final String title;
  final Function action;

  MainButton(this.title, this.action);

  @override
  Widget build(BuildContext context) {
    return TextButton(
        onPressed: () => action(),
        style: TextButton.styleFrom(
          backgroundColor: Colors.black.withOpacity(0.4),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          fixedSize: Size(220, 55),
          elevation: 0,
        ),
        child: Text(
          title,
          style: TextStyle(fontSize: 27, color: Colors.white),
        ));
  }
}
