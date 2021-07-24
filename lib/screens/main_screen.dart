import 'package:flutter/material.dart';

import '../screens/about_screen.dart';
import 'score_screen.dart';
import 'play_screen.dart';
import '../widgets/main_button.dart';
import '../data.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: BoxDecoration(
          gradient: LinearGradient(
              colors: GRADIENT_THEME[currentTheme],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            '2048',
            style: TextStyle(
              color: Colors.white,
              fontFamily: 'Manrope',
              fontSize: 70,
              fontWeight: FontWeight.w800,
              decoration: TextDecoration.none,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                child: Icon(
                  Icons.chevron_left,
                  color: currentBoard > 0
                      ? Colors.white.withOpacity(0.4)
                      : Colors.transparent,
                  size: 36,
                ),
                onTap: () {
                  if (currentBoard > 0)
                    setState(() {
                      currentBoard--;
                    });
                },
              ),
              Text(
                boards[currentBoard].title +
                    ' (${boards[currentBoard].size}×${boards[currentBoard].size})',
                style: TextStyle(
                  color: Colors.white.withOpacity(0.6),
                  fontFamily: 'Manrope',
                  fontSize: 23,
                  fontWeight: FontWeight.w400,
                  decoration: TextDecoration.none,
                ),
              ),
              GestureDetector(
                child: Icon(
                  Icons.chevron_right,
                  color: currentBoard < boards.length - 1
                      ? Colors.white.withOpacity(0.4)
                      : Colors.transparent,
                  size: 36,
                ),
                onTap: () {
                  if (currentBoard < boards.length - 1)
                    setState(() {
                      currentBoard++;
                    });
                },
              ),
            ],
          ),
          SizedBox(height: 30),
          MainButton('PLAY', () {
            Navigator.of(context).pushNamed(PlayScreen.routeName).then((value) {
              // widget.storage
              //     .writeData(boards.map((board) => board.toString()).toList());
            });
          }),
          SizedBox(height: 15),
          MainButton('SCORE', () {
            Navigator.of(context).pushNamed(ScoreScreen.routeName);
          }),
          SizedBox(height: 15),
          MainButton('THEME', () {
            setState(() {
              currentTheme = (currentTheme + 1) % GRADIENT_THEME.length;
            });
          }),
          SizedBox(height: 15),
          MainButton('ABOUT', () {
            Navigator.of(context).pushNamed(AboutScreen.routeName);
          }),
        ],
      ),
    );
  }
}
