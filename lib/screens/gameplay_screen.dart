import 'package:flutter/material.dart';
import 'package:simple_gesture_detector/simple_gesture_detector.dart';

import '../widgets/game_button.dart';
import '../data.dart';

class GameplayScreen extends StatefulWidget {
  static const routeName = '/gameplay';

  @override
  _State createState() => _State();
}

class _State extends State<GameplayScreen> {
  bool showGameOver = false;

  Widget scoreDisplay(String title, int score) {
    return Card(
      color: Colors.black.withOpacity(0.3),
      shadowColor: Colors.transparent,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      margin: EdgeInsets.zero,
      child: Padding(
        padding: const EdgeInsets.only(left: 8, right: 8, top: 7),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(
                  color: Colors.white60,
                  fontFamily: 'Manrope',
                  fontSize: 10,
                  fontWeight: FontWeight.bold),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 5),
              child: Text(
                '$score',
                style: TextStyle(
                    color: Colors.white,
                    fontFamily: 'Manrope',
                    fontSize: 22,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
            gradient: LinearGradient(
                colors: GRADIENT_THEME[currentTheme],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight)),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '2048',
                    style: TextStyle(
                      color: Colors.white,
                      fontFamily: 'Manrope',
                      fontSize: 58,
                      fontWeight: FontWeight.w800,
                      decoration: TextDecoration.none,
                    ),
                  ),
                  Row(
                    children: [
                      scoreDisplay('SCORE', boards[currentBoard].currentScore),
                      SizedBox(width: 10),
                      scoreDisplay(
                          'HIGH SCORE', boards[currentBoard].highScore),
                    ],
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  GameButton(Icons.home, () {
                    Navigator.of(context).pop();
                  }),
                  SizedBox(width: 15),
                  GameButton(Icons.undo, () {
                    setState(() {
                      boards[currentBoard].rollback();
                    });
                  }),
                  SizedBox(width: 15),
                  GameButton(Icons.cached, () {
                    setState(() {
                      boards[currentBoard].reset();
                    });
                  }),
                ],
              ),
              SizedBox(height: 16),
              Container(
                child: SimpleGestureDetector(
                  swipeConfig: SimpleSwipeConfig(
                      verticalThreshold: 20,
                      horizontalThreshold: 20,
                      swipeDetectionBehavior: SwipeDetectionBehavior.singular),
                  onVerticalSwipe: (direction) {
                    if (direction == SwipeDirection.up) {
                      setState(() {
                        boards[currentBoard].up();
                      });
                    } else
                      setState(() {
                        boards[currentBoard].down();
                      });

                    if (boards[currentBoard].isOver) {
                      setState(() {
                        showGameOver = true;
                      });
                    }
                  },
                  onHorizontalSwipe: (direction) {
                    if (direction == SwipeDirection.left) {
                      setState(() {
                        boards[currentBoard].left();
                      });
                    } else
                      setState(() {
                        boards[currentBoard].right();
                      });

                    if (boards[currentBoard].isOver) {
                      setState(() {
                        showGameOver = true;
                      });
                    }
                  },
                  child: Container(
                    height: MediaQuery.of(context).size.width - 16 * 2,
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.black.withOpacity(0.3),
                    ),
                    child: GridView.builder(
                        padding: EdgeInsets.zero,
                        physics: NeverScrollableScrollPhysics(),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: boards[currentBoard].size,
                            mainAxisSpacing: 8,
                            crossAxisSpacing: 8),
                        itemCount: boards[currentBoard].size *
                            boards[currentBoard].size,
                        itemBuilder: (BuildContext context, int index) {
                          int value = boards[currentBoard].valueAt(index);
                          return Container(
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: CELL_COLOR[value],
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: value == 0
                                ? null
                                : FittedBox(
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 25),
                                      child: Text(
                                        '$value',
                                        style: TextStyle(
                                          color: value <= 4
                                              ? Color.fromRGBO(81, 81, 81, 1)
                                              : Colors.white,
                                          decoration: TextDecoration.none,
                                        ),
                                      ),
                                    ),
                                  ),
                          );
                        }),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      if (showGameOver)
        GestureDetector(
            onTap: () {
              setState(() {
                showGameOver = false;
              });
            },
            child: Container(
              color: Colors.black.withOpacity(0.1),
              child: Center(
                child: Text(
                  'Game Over!',
                  style: TextStyle(
                      color: Colors.white,
                      fontFamily: 'Manrope',
                      fontSize: 60,
                      fontWeight: FontWeight.bold,
                      decoration: TextDecoration.none),
                ),
              ),
            )),
    ]);
  }
}
