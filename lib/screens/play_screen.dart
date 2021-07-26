import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:simple_gesture_detector/simple_gesture_detector.dart';

import '../widgets/game_button.dart';
import '../data.dart';

class PlayScreen extends StatefulWidget {
  static const routeName = '/play';

  @override
  _State createState() => _State();
}

class _State extends State<PlayScreen> {
  bool showGameOver = false;

  void handleMovement(String direction) {
    if (direction == 'up') {
      setState(() {
        boards[currentBoard].up();
      });
    } else if (direction == 'down') {
      setState(() {
        boards[currentBoard].down();
      });
    } else if (direction == 'left') {
      setState(() {
        boards[currentBoard].left();
      });
    } else if (direction == 'right') {
      setState(() {
        boards[currentBoard].right();
      });
    } else
      return;

    if (boards[currentBoard].isOver) {
      setState(() {
        showGameOver = true;
      });
    }

    repo.writeData(boards.map((board) => board.toString()).toList());
  }

  Widget scoreDisplay(String title, int score) {
    return Card(
      color: Colors.black.withOpacity(0.3),
      shadowColor: Colors.transparent,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      margin: EdgeInsets.zero,
      child: Padding(
        padding: const EdgeInsets.only(left: 8, right: 8, top: 7),
        child: FittedBox(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text(
                title,
                style: TextStyle(
                    color: Colors.white60,
                    fontFamily: 'Manrope',
                    fontSize: 15,
                    fontWeight: FontWeight.bold),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 5),
                child: Text(
                  '$score',
                  style: TextStyle(
                      color: Colors.white,
                      fontFamily: 'Manrope',
                      fontSize: 28,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        RawKeyboardListener(
          autofocus: true,
          focusNode: FocusNode(),
          onKey: (RawKeyEvent event) {
            if (event is RawKeyDownEvent) {
              if (event.isKeyPressed(LogicalKeyboardKey.arrowUp) ||
                  event.isKeyPressed(LogicalKeyboardKey.keyW))
                handleMovement('up');
              else if (event.isKeyPressed(LogicalKeyboardKey.arrowDown) ||
                  event.isKeyPressed(LogicalKeyboardKey.keyS))
                handleMovement('down');
              else if (event.isKeyPressed(LogicalKeyboardKey.arrowLeft) ||
                  event.isKeyPressed(LogicalKeyboardKey.keyA))
                handleMovement('left');
              else if (event.isKeyPressed(LogicalKeyboardKey.arrowRight) ||
                  event.isKeyPressed(LogicalKeyboardKey.keyD))
                handleMovement('right');
            }
          },
          child: Container(
            width: double.infinity,
            height: double.infinity,
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    colors: GRADIENT_THEME[currentTheme],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight)),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 60),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Flexible(
                    flex: 1,
                    child: Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: EdgeInsets.zero,
                            child: FittedBox(
                              child: Text(
                                '2048',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: 'Manrope',
                                  fontSize: 70,
                                  fontWeight: FontWeight.w800,
                                  decoration: TextDecoration.none,
                                ),
                              ),
                            ),
                          ),
                          Row(
                            children: [
                              scoreDisplay(
                                  'SCORE', boards[currentBoard].currentScore),
                              SizedBox(width: 10),
                              scoreDisplay(
                                  'HIGH SCORE', boards[currentBoard].highScore),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  Flexible(
                    flex: 1,
                    child: Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          GameButton(
                              icon: Icons.home,
                              action: () {
                                Navigator.of(context).pop();
                              }),
                          SizedBox(width: 15),
                          GameButton(
                              icon: Icons.undo,
                              action: () {
                                setState(() {
                                  boards[currentBoard].rollback();
                                });
                              }),
                          SizedBox(width: 15),
                          GameButton(
                            icon: Icons.cached,
                            highlight: boards[currentBoard].isOver,
                            action: () {
                              setState(() {
                                boards[currentBoard].reset();
                              });
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                  Flexible(
                    flex: 8,
                    child: Container(
                      child: AspectRatio(
                        aspectRatio: 1 / 1,
                        child: Container(
                          child: SimpleGestureDetector(
                            swipeConfig: SimpleSwipeConfig(
                                verticalThreshold: 20,
                                horizontalThreshold: 20,
                                swipeDetectionBehavior:
                                    SwipeDetectionBehavior.singular),
                            onVerticalSwipe: (direction) {
                              if (direction == SwipeDirection.up) {
                                handleMovement('up');
                              } else if (direction == SwipeDirection.down) {
                                handleMovement('down');
                              }
                            },
                            onHorizontalSwipe: (direction) {
                              if (direction == SwipeDirection.left) {
                                handleMovement('left');
                              } else if (direction == SwipeDirection.right) {
                                handleMovement('right');
                              }
                            },
                            child: Container(
                              padding: const EdgeInsets.all(6),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.black.withOpacity(0.3),
                              ),
                              child: GridView.builder(
                                  padding: EdgeInsets.zero,
                                  physics: NeverScrollableScrollPhysics(),
                                  gridDelegate:
                                      SliverGridDelegateWithFixedCrossAxisCount(
                                          crossAxisCount:
                                              boards[currentBoard].size,
                                          mainAxisSpacing: 6,
                                          crossAxisSpacing: 6),
                                  itemCount: boards[currentBoard].size *
                                      boards[currentBoard].size,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    int value =
                                        boards[currentBoard].valueAt(index);
                                    return Container(
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                        color: value <= 2048
                                            ? CELL_COLOR[currentTheme][value]
                                            : CELL_COLOR[(currentTheme + 1) % 3]
                                                [value / 8],
                                        borderRadius: BorderRadius.circular(6),
                                      ),
                                      child: value == 0
                                          ? null
                                          : FittedBox(
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        vertical: 25),
                                                child: Text(
                                                  '$value',
                                                  style: TextStyle(
                                                    color: value <= 4
                                                        ? Color.fromRGBO(
                                                            81, 81, 81, 1)
                                                        : Colors.white,
                                                    decoration:
                                                        TextDecoration.none,
                                                  ),
                                                ),
                                              ),
                                            ),
                                    );
                                  }),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
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
                color: Colors.black.withOpacity(0.15),
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
      ],
    );
  }
}
