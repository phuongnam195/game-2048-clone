import 'package:flutter/material.dart';

import '../data.dart';

class ScoreScreen extends StatelessWidget {
  static const routeName = '/score';

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
        child: Center(
          child: Container(
            width: MediaQuery.of(context).size.height / 2,
            child: GridView.builder(
                shrinkWrap: true,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 25,
                    mainAxisSpacing: 25),
                itemCount: boards.length,
                itemBuilder: (BuildContext context, index) {
                  return Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: Colors.black26),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Flexible(
                            flex: 1,
                            child: FittedBox(
                              child: Text(
                                'Help center',
                                style: TextStyle(
                                  color: Colors.transparent,
                                  fontFamily: 'Manrope',
                                  fontSize: 20,
                                  fontWeight: FontWeight.w500,
                                  decoration: TextDecoration.none,
                                ),
                              ),
                            ),
                          ),
                          Flexible(
                            flex: 3,
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              child: FittedBox(
                                child: Text('${boards[index].highScore}',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontFamily: 'Manrope',
                                      fontSize: 80,
                                      fontWeight: FontWeight.w600,
                                      decoration: TextDecoration.none,
                                    )),
                              ),
                            ),
                          ),
                          Flexible(
                            flex: 1,
                            child: FittedBox(
                              child: Text(
                                boards[index].title +
                                    ' (${boards[index].size}×${boards[index].size})',
                                style: TextStyle(
                                  color: Colors.white70,
                                  fontFamily: 'Manrope',
                                  fontSize: 20,
                                  fontWeight: FontWeight.w500,
                                  decoration: TextDecoration.none,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ));
                }),
          ),
        ));
  }
}
